const { User } = require("../common/user");
const { MatchDbModel } = require("../models/match-db-model");
const { UserDbModel } = require("../models/user-db-model");

class ChatHandler {
	makeMatchObject(user, chatInfo) {
		const {
			id,
			firstName,
			lastName,
			age,
			sex,
			religion,
			bio,
			photoUrl,
			hobbies,
		} = user;
		const { unreadCount, chatId } = chatInfo;
		const appointment = "01/07/18";

		const match = {
			chatId,
			partnerId: id,
			firstName,
			lastName,
			age,
			sex,
			religion,
			bio,
			hobbies,
			photoUrl,
			unreadCount,
			appointment,
		};
		return match;
	}
	//convinent
	async getMatches(myId) {
		const userAndChatInfo = await this.getUserAndChatInfo(myId);

		const matches = [];
		for (const { user, chatInfo } of userAndChatInfo) {
			matches.push(this.makeMatchObject(user, chatInfo));
		}
		return matches;
	}

	async getMessages(userId, chatId) {
		const matchDoc = await MatchDbModel.findOne({ _id: chatId });
		const isBoy = userId === matchDoc.boyId.toString();

		const messages = matchDoc.messages;
		const perspectiveMessages = [];

		for (const { content, sentByBoy } of messages) {
			const sentBySelf = (isBoy && sentByBoy) || (!isBoy && !sentByBoy);
			const perspectiveMessage = { content, sentBySelf };
			perspectiveMessages.push(perspectiveMessage);
		}

		return perspectiveMessages;
	}

	async getUserAndChatInfo(myId) {
		const instruction = { $or: [{ boyId: myId }, { girlId: myId }] };
		const matchDocs = await MatchDbModel.find(instruction);
		if (!matchDocs.length) return [];

		const amBoy = matchDocs[0].boyId.toString() === myId;
		const userAndChatInfoPromises = [];

		for (const matchDoc of matchDocs) {
			const otherUserId = amBoy ? matchDoc.girlId : matchDoc.boyId;
			const chatId = matchDoc._id.toString();
			const unreadCount = amBoy
				? matchDoc.unreadByBoyCount
				: matchDoc.unreadByGirlCount;

			const promise = this.userAndChatInfoPromise(
				otherUserId,
				chatId,
				unreadCount
			);
			userAndChatInfoPromises.push(promise);
		}

		return await Promise.all(userAndChatInfoPromises);
	}

	userAndChatInfoPromise(otherUserId, chatId, unreadCount) {
		return UserDbModel.findOne({ _id: otherUserId }).then((otherUserDoc) => {
			const user = new User(otherUserDoc).getPublicInfo();
			const chatInfo = { unreadCount, chatId };
			return { user, chatInfo };
		});
	}

	async getUserAndMessages(userId, chatId) {
		const matchDoc = await MatchDbModel.findOne({ _id: chatId });
		const isBoy = userId === matchDoc.boyId.toString();

		const otherUserId = isBoy ? matchDoc.girlId : matchDoc.boyId;

		const otherUserDoc = await UserDbModel.findOne({ _id: otherUserId });
		const otherUser = new User(otherUserDoc);
		const otherUserPublicInfo = otherUser.getPublicInfo();

		return {
			user: otherUserPublicInfo,
			messages: matchDoc.messages,
		};
	}

	async setAppointment(appointment, chatId) {
		const result = await MatchDbModel.updateOne(
			{ _id: chatId },
			{ appointment: appointment }
		);
		return { appointment };
	}

	async deleteAppointment(chatId) {
		return this.setAppointment(null, chatId);
	}
}

const chatHandler = new ChatHandler();
module.exports = { chatHandler };
