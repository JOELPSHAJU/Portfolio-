import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  final url = Uri.parse('https://api.web3forms.com/submit');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    body: jsonEncode({
      'access_key': 'e3d5fbb9-4a97-47d5-b98e-30d4c64f21c3',
      'name': 'Dart CLI Test',
      'email': 'joelpshaju@gmail.com',
      'message': 'This is a test from Dart CLI to see if Web3Forms is working.',
      'subject': 'Test Portfolio Inquiry'
    }),
  );
  print('Status: ${response.statusCode}');
  print('Body: ${response.body}');
}
