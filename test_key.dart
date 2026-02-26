import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  const apiKey = 'AIzaSyCQuhGtyRJWG9edl-tMXNuqKTy7STJH4xs';
  final models = [
    'gemini-flash-latest',
    'gemini-pro-latest',
    'gemini-2.0-flash',
    'gemini-2.5-flash'
  ];
  
  print('Testing API Key: ${apiKey.substring(0, 5)}...');
  
  for (final modelName in models) {
    print('\nTesting $modelName (v1)...');
    try {
      final model = GenerativeModel(
        model: modelName,
        apiKey: apiKey,
        requestOptions: const RequestOptions(apiVersion: 'v1'),
      );
      final response = await model.generateContent([Content.text('Hi')]);
      print('SUCCESS (v1): ${response.text?.substring(0, 20)}');
    } catch (e) {
      print('ERROR (v1): $e');
    }

    print('Testing $modelName (v1beta)...');
    try {
      final model = GenerativeModel(
        model: modelName,
        apiKey: apiKey,
        requestOptions: const RequestOptions(apiVersion: 'v1beta'),
      );
      final response = await model.generateContent([Content.text('Hi')]);
      print('SUCCESS (v1beta): ${response.text?.substring(0, 20)}');
    } catch (e) {
      print('ERROR (v1beta): $e');
    }
  }
}
