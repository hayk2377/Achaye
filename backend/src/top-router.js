const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const cors = require("cors");

const { sessionMiddleware } = require("./common/session");
const { jwtMiddleWare } = require("./common/jwt");
const { MONGO_URL } = require("./common/mongo-url");
const { accountRouter } = require("./account/account-router");
const { matchingRouter } = require("./matching/matching-router");
const { chattingRouter } = require("./chatting/chatting-router");

mongoose.set("strictQuery", false);
mongoose.connect(MONGO_URL);

router.get("/hi", (req, res) => res.json({ helloworld: "helloworld" }));
router.get("/test-users", async (req, res) => {
	const { importBoysAndGirls } = require("./matching/suggester-dependencies");
	const result = await importBoysAndGirls();
	res.json(result);
});

router.use(cors());
router.use(sessionMiddleware);
router.use(jwtMiddleWare);

router.get("/log-test", (req, res) => res.send("ur logged in"));

router.use(accountRouter);
router.use(matchingRouter);
router.use(chattingRouter);

module.exports = { topRouter: router };
