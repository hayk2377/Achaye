const jwt = require("jsonwebtoken");

const secret =
	"09f26e402586e2faa8da4c98a35f1b20d6b033c6097befa8be3486a829587fe2f90a832bd3ff9d42710a4da095a2ce285b009f0c3730cd9b8e1af3eb84df6611";

function generateAccessToken(userId) {
	//{ expiresIn: "1800s" }
	const token = jwt.sign({ userId }, secret);
	return token;
}

async function jwtMiddleWare(req, res, next) {
	const authHeader = req.headers["authorization"];
	const token = authHeader && authHeader.split(" ")[1];

	console.log(req.headers);
	if (!token) return next();

	const { userId } = jwt.verify(token, secret);
	console.log("found user id in jwt!", userId);
	req.session.userId = userId;
	next();
}

module.exports = { generateAccessToken, jwtMiddleWare };
