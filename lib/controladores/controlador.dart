// Controlador para gestionar el estado de la aplicación con GetX
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pro006/main.dart';

class LoginController extends GetxController {
  var isLoggedIn = false.obs;
  var hasScannerAccess = false.obs;
  var isUserAdmin = false.obs;
  var isLoading = false.obs;
  var nombresUsuario = "".obs;
  var datosUsuario = {}.obs;

  Future<void> login(String identificacion, String password) async {
    isLoading.value = true;
    try {
      // Encriptar la contraseña con MD5
      final md5Password = md5.convert(utf8.encode(password)).toString();

      // Construir la URL de la consulta para Supabase
      final url = Uri.parse(
        '$supabaseUrl?identificacion=eq.$identificacion&password=eq.$md5Password',
      );

      // Realizar la petición HTTP GET
      final response = await http.get(
        url,
        headers: {
          'apikey': supabaseApiKey,
          'Authorization': 'Bearer $supabaseApiKey',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          // Si se encontró un registro, la autenticación es exitosa
          final userData = data.first;
          datosUsuario.value = userData;
          isLoggedIn.value = true;
          hasScannerAccess.value = userData['scanner'] ?? false;
          isUserAdmin.value = userData['usuario'] ?? false;
          isUserAdmin.value = userData['usuario'] ?? false;
          nombresUsuario.value = userData['nombres'] ?? '';
          Get.snackbar(
            'Bienvenido!',
            nombresUsuario.value,
            backgroundColor: Colors.green[400],
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          // No se encontró ningún registro con esas credenciales
          Get.snackbar(
            'Error de Autenticación',
            'Identificación o contraseña incorrecta.',
            backgroundColor: Colors.red[400],
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        // Manejar errores de la API
        Get.snackbar(
          'Error del Servidor',
          'Código de estado: ${response.statusCode}',
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Manejar errores de conexión
      Get.snackbar(
        'Error de Conexión',
        'No se pudo conectar al servidor. Intente de nuevo.',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    isLoggedIn.value = false;
    hasScannerAccess.value = false;
    isUserAdmin.value = false;
    Get.snackbar(
      'Sesión Cerrada',
      '${nombresUsuario.value} vuelve pronto...',
      backgroundColor: Colors.orange[400],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
