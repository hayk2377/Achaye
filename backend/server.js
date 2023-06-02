const express = require("express");
const { handleNewWebSocket } = require("./chatting/ws-connection");

const app = express();
const http = require("http");
const WebSocket = require("ws");

const { topRouter } = require("./top-router");

app.use("/api", topRouter);

const server = http.createServer(app);
const webSocketServer = new WebSocket.Server({ server });
webSocketServer.on("connection", handleNewWebSocket);

const PORT = 3000;
server.listen(PORT, () => console.log(`listen ${PORT}`));
