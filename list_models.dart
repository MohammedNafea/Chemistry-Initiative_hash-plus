import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  const apiKey = 'AIzaSyCQuhGtyRJWG9edl-tMXNuqKTy7STJH4xs';
  print('Listing models for API Key: ${apiKey.substring(0, 10)}...');

  final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models?key=$apiKey');
  
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final models = data['models'] as List?;
      if (models != null) {
        print('Available Models:');
        for (var model in models) {
          print('- ${model['name']} (${model['displayName']})');
          print('  Methods: ${model['supportedGenerationMethods']}');
        }
      } else {
        print('No models found in response.');
      }
    } else {
      print('FAILED to list models: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('ERROR: $e');
  }
}
