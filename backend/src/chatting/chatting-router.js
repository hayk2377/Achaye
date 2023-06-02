const express = require("express");
const router = express.Router();
const { logGuard } = require("../common/log-guard");
const { chatHandler } = require("./chat-handler");

router.use(logGuard);

//<new>
router.get("/matches", async (req, res) => {
	const userId = req.session.userId;
	const result = await chatHandler.getMatches(userId);
	res.json(result);
});

router.get("/messages/:chatId", async (req, res) => {
	const chatId = req.params.chatId;
	const userId = req.session.userId;
	const result = await chatHandler.getMessages(userId, chatId);
	res.json(result);
});

router.post("/appointments/:chatId", async (req, res) => {
	const chatId = req.params.chatId;
	const appointment = req.body.appointment;
	const result = await chatHandler.setAppointment(appointment, chatId);
	res.json(result);
});

router.put("/appointments/:chatId", async (req, res) => {
	const chatId = req.params.chatId;
	const appointment = req.body.appointment;

	const result = await chatHandler.setAppointment(appointment, chatId);
	res.json(result);
});

router.delete("/appointments/:chatId", async (req, res) => {
	const chatId = req.params.chatId;
	const result = await chatHandler.deleteAppointment(chatId);
	res.json(result);
});

//</new>

router.get("/chats", async (req, res) => {
	const userId = req.session.userId;
	const result = await chatHandler.getUserAndChatInfo(userId);
	res.json(result);
});

router.get("/chats/:chatId", async (req, res) => {
	const chatId = req.params.chatId;
	const userId = req.session.userId;
	const result = await chatHandler.getUserAndMessages(userId, chatId);
	res.json(result);
});

module.exports = { chattingRouter: router };
