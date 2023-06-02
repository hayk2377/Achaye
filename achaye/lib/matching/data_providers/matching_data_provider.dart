import 'dart:convert';
import 'package:achaye/utils/json_header.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class MatchingDataProvider {
  final String baseUrl;
  late final String webSocketBaseUrl;
  HeaderProvider headerProvider;

  MatchingDataProvider({required this.baseUrl, required this.headerProvider}) {
    var uri = Uri.parse(baseUrl);
    var hostName = uri.host;
    var port = uri.port;
    webSocketBaseUrl = "ws://$hostName:$port/";
    print('websocket url is $webSocketBaseUrl');
  }

  Future<http.Response> getSuggestions() async {
    var response = await http.get(Uri.parse('$baseUrl/suggestions'),
        headers: await headerProvider.create());

    return response;
  }

  Future<http.Response> getOtherUser(String otherUserId) async {
    var response = await http.get(Uri.parse('$baseUrl/otherusers/$otherUserId'),
        headers: await headerProvider.create());

    return response;
  }

  Future<http.Response> like(String likedId) async {
    var response = await http.post(
      Uri.parse('$baseUrl/likes'),
      headers: await headerProvider.create(),
      body: jsonEncode({"userId": likedId}),
    );

    return response;
  }

  Future<http.Response> dislike(String dislikedId) async {
    var response = await http.post(
      Uri.parse('$baseUrl/likes'),
      headers: await headerProvider.create(),
      body: jsonEncode({"userId": dislikedId}),
    );

    return response;
  }

  Future<http.Response> getMatches() async {
    var response = await http.get(Uri.parse('$baseUrl/matches'),
        headers: await headerProvider.create());

    return response;
  }

  Future<http.Response> getMessages(String chatId) async {
    var response = await http.get(Uri.parse('$baseUrl/messages/$chatId'),
        headers: await headerProvider.create());

    return response;
  }

  Future<http.Response> createAppointment(
      String chatId, String appointment) async {
    var response = await http.post(
        Uri.parse(
          '$baseUrl/appointments/$chatId/',
        ),
        headers: await headerProvider.create(),
        body: jsonEncode({"appointment": appointment}));
    return response;
  }

  Future<http.Response> deleteAppointment(String chatId) async {
    var response = await http.delete(
      Uri.parse('$baseUrl/appointments/$chatId'),
      headers: await headerProvider.create(),
    );
    return response;
  }

  Future<http.Response> editAppointment(
      String chatId, String appointment) async {
    var response = await http.put(Uri.parse('$baseUrl/appointments/$chatId/'),
        headers: await headerProvider.create(),
        body: jsonEncode({"appointment": appointment}));
    return response;
  }

  WebSocketChannel getWebSocketChannel(chatId) {
    print(webSocketBaseUrl);
    var channel =
        WebSocketChannel.connect(Uri.parse('$webSocketBaseUrl/$chatId'));
    print('trying to connect to $webSocketBaseUrl/$chatId}');
    return channel;
  }
}
