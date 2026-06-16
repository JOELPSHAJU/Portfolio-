import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  final url = Uri.parse('https://formsubmit.co/ajax/joelpshaju@gmail.com');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Origin': 'https://joelpshaju.github.io'
    },
    body: jsonEncode({
      'name': 'Joel Test',
      'email': 'joelpshaju@gmail.com',
      'message': 'This is a test message from Dart with Origin spoof.'
    }),
  );
  print(response.statusCode);
  print(response.body);
}
