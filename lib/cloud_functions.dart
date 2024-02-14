import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

Future<void> callCloudFunctionWithPdf() async {
  // Seleccionar un archivo PDF
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    PlatformFile file = result.files.first;

    var uri =
        Uri.parse('https://annotate-http-xacmlyv5xa-uc.a.run.app/annotate');

    // Crear una petición HTTP Multipart
    var request = http.MultipartRequest("POST", uri)
      ..fields['features'] = "FACE_DETECTION,IMAGE_PROPERTIES,LABEL_DETECTION"
      // Asumiendo que el backend acepta un archivo con una clave específica, por ejemplo 'pdf'
      ..files.add(await http.MultipartFile.fromPath('pdf', file.path!));

    try {
      // Enviar la petición
      var response = await request.send();
        
      if (response.statusCode == 200) {
        // Si la petición fue exitosa, leer y decodificar la respuesta
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        if (kDebugMode) {
          print("Respuesta recibida: $responseString");
        }
      } else {
        // Si la petición falló, mostrar el código de estado
        if (kDebugMode) {
          print("Error en la petición: ${response.statusCode}");
        }
      }
    } catch (e) {
      // Manejar cualquier excepción que pueda ocurrir durante la petición
      if (kDebugMode) {
        print("Excepción al realizar la petición: $e");
      }
    }
  } else {
    // El usuario canceló la selección del archivo
    if (kDebugMode) {
      print("Selección de archivo cancelada");
    }
  }
}
