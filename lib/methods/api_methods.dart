import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../methods/private_keys.dart';

Future<String> sendImageToBackend(Uint8List imageBytes, String language) async {
  try {
    final uri = Uri.parse(
      'http://$baseIp:$basePort/process-image',
    ); // Backend URL
    final request =
        http.MultipartRequest('POST', uri)
          ..files.add(
            http.MultipartFile.fromBytes(
              'image', // Backend'de beklenen parametre adı
              imageBytes,
              filename: 'image.png', // Dosya adı
            ),
          )
          ..fields['language'] = language;

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      return data['text'] ?? 'No text recognized.';
    } else {
      return 'Failed to process image. Status code: ${response.statusCode}';
    }
  } catch (e) {
    return 'Error: $e';
  }
}
