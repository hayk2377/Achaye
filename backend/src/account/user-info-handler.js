const { UserDbModel } = require("../models/user-db-model");
const { suggester } = require("../matching/suggester");

const { MatchDbModel } = require("../models/match-db-model");
const { LikeDbModel } = require("../models/like-db-model");
const { DislikeDbModel } = require("../models/dislike-db-model");

const { formatProfile } = require("./format-profile");
const { User } = require("../common/user");

class UserInfoHandler {
	signup() {
		//64766eb7e37fddeaeec8dc7c
		//64766eb7e37fddeaeec8dc7c
	}

	async fillProfile(newProfile) {
		formatProfile(newProfile);
		console.log("before", newProfile);
		const newUserDocument = new UserDbModel(newProfile);
		try {
			const result = await newUserDocument.save();
			console.log("after", newProfile);

			suggester.updateUsers();
			return result;
		} catch (error) {
			if (error.code === 11000) {
				return { error: "email is already used", code: 11000 };
			} else {
				throw error;
			}
		}
	}

	async getProfile(userId) {
		const userDocument = await UserDbModel.findOne({ _id: userId });
		console.log(userDocument);
		return userDocument;
	}

	async deletePreferences(profile, userId) {
		const preferenceNames = ["hobbies", "religiousPreferences"];
		for (const preferenceName of preferenceNames) {
			profile[preferenceName] = "";
		}

		return await this.editProfile(profile, userId);
	}

	async editProfile(editedProfile, userId) {
		//unchangable parts
		delete editedProfile.sex;
		delete editedProfile.email;
		delete editedProfile.firstName;
		delete editedProfile.lastName;

		formatProfile(editedProfile);

		suggester.updateScores();
		const result = await UserDbModel.updateOne({ _id: userId }, editedProfile);
		const document = await UserDbModel.findOne({ _id: userId });
		return document;
	}

	async deleteAccount(userId) {
		const mResult = await MatchDbModel.deleteOne({
			$or: [{ boyId: userId }, { girlId: userId }],
		});
		const lResult = await LikeDbModel.deleteOne({ _id: userId });
		const dResult = await DislikeDbModel.deleteOne({ _id: userId });
		const uResult = await UserDbModel.deleteOne({ _id: userId });
		return { isDeleted: true };
	}
}

const userInfoHandler = new UserInfoHandler();
module.exports = { userInfoHandler };

async function test() {
	console.log(await userInfoHandler.getProfile(1));
}
//test();
