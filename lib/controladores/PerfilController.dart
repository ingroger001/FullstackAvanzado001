import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pro006/controladores/controlador.dart';
import 'package:pro006/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PerfilController extends GetxController {
  final LoginController _loginController = Get.find();
  var isLoadingUpdate = false.obs;
  var isLoadingPhoto = false.obs;

  final supabaseClient = Supabase.instance.client;

  Future<void> actualizarDatosUsuario({
    required String nombres,
    required String direccion,
    required String email,
    required String telefono,
  }) async {
    isLoadingUpdate.value = true;
    try {
      final userId = _loginController.datosUsuario['id'];
      if (userId == null) {
        Get.snackbar(
          'Error',
          'No se pudo obtener el ID del usuario.',
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final url = Uri.parse('$supabaseUrl/personas?id=eq.$userId');
      final updatedData = {
        'nombres': nombres,
        'direccion': direccion,
        'email': email,
        'telefono': telefono,
      };

      final response = await http.patch(
        url,
        headers: {
          'apikey': supabaseApiKey,
          'Authorization': 'Bearer $supabaseApiKey',
          'Content-Type': 'application/json',
          'Prefer': 'return=minimal',
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 204) {
        // La actualización fue exitosa (código 204 No Content)
        Get.snackbar(
          '¡Éxito!',
          'Tus datos han sido actualizados.',
          backgroundColor: Colors.green[400],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        // Opcional: Actualizar los datos locales del controlador de login
        _loginController.datosUsuario['nombres'] = nombres;
        _loginController.datosUsuario['direccion'] = direccion;
        _loginController.datosUsuario['email'] = email;
        _loginController.datosUsuario['telefono'] = telefono;
        _loginController.nombresUsuario.value = nombres;
      } else {
        Get.snackbar(
          'Error',
          'No se pudo actualizar el perfil. Código de estado: ${response.statusCode}',
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error de Conexión',
        'No se pudo conectar al servidor. Intente de nuevo.',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingUpdate.value = false;
    }
  }

  Future<void> cargarFotoDePerfil() async {
    isLoadingPhoto.value = true;
    try {
      final userId = _loginController.datosUsuario['id'];
      if (userId == null) {
        Get.snackbar(
          'Error',
          'No se pudo obtener el ID del usuario.',
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final pickedFile = await FilePicker.platform.pickFiles();
      final archivo = pickedFile?.files.first;

      if (pickedFile != null) {
        final imageBytes = await archivo?.bytes;
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${archivo?.name}';

        // Subir la imagen al bucket
        await supabaseClient.storage
            .from('documentos')
            .uploadBinary(
              fileName,
              imageBytes!,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: true,
              ),
            );

        // Obtener la URL pública
        final publicUrl = supabaseClient.storage
            .from('documentos')
            .getPublicUrl(fileName);

        // Actualizar la URL en la tabla 'personas'
        await supabaseClient
            .from('personas')
            .update({'urlfoto': publicUrl})
            .eq('id', userId);

        _loginController.datosUsuario['urlfoto'] = publicUrl;

        Get.snackbar(
          '¡Éxito!',
          'Foto de perfil actualizada correctamente.',
          backgroundColor: Colors.green[400],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo cargar la foto. Error: $e',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingPhoto.value = false;
    }
  }
}
