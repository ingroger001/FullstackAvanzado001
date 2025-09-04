import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro006/controladores/PerfilController.dart';
import 'package:pro006/controladores/controlador.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final LoginController _loginController = Get.find();
  final PerfilController _perfilController = Get.put(PerfilController());

  late final TextEditingController nombresController;
  late final TextEditingController direccionController;
  late final TextEditingController emailController;
  late final TextEditingController telefonoController;

  @override
  void initState() {
    super.initState();
    final userData = _loginController.datosUsuario.value;
    nombresController = TextEditingController(text: userData['nombres'] ?? '');
    direccionController = TextEditingController(
      text: userData['direccion'] ?? '',
    );
    emailController = TextEditingController(text: userData['email'] ?? '');
    telefonoController = TextEditingController(
      text: userData['telefono'] ?? '',
    );
  }

  @override
  void dispose() {
    nombresController.dispose();
    direccionController.dispose();
    emailController.dispose();
    telefonoController.dispose();
    Get.delete<PerfilController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = _loginController.datosUsuario.value;
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FE),
      appBar: AppBar(
        title: const Text('Mi Perfil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 500,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Obx(() {
                          final imageUrl =
                              _loginController.datosUsuario['urlfoto'] ?? '';
                          return CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300],
                            child:
                                imageUrl.isEmpty
                                    ? const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.grey,
                                    )
                                    : ClipOval(
                                      child: Image.network(
                                        imageUrl,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return const Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.grey,
                                          );
                                        },
                                      ),
                                    ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Identificación: ${userData['identificacion']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nombresController,
                        decoration: InputDecoration(
                          labelText: 'Nombres',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.badge),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: direccionController,
                        decoration: InputDecoration(
                          labelText: 'Dirección',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.home),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.email),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: telefonoController,
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.phone),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4267B2),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed:
                              _perfilController.isLoadingUpdate.value
                                  ? null
                                  : () {
                                    _perfilController.actualizarDatosUsuario(
                                      nombres: nombresController.text,
                                      direccion: direccionController.text,
                                      email: emailController.text,
                                      telefono: telefonoController.text,
                                    );
                                  },
                          child:
                              _perfilController.isLoadingUpdate.value
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    'Actualizar Datos',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed:
              _perfilController.isLoadingPhoto.value
                  ? null
                  : () async {
                    await _perfilController.cargarFotoDePerfil();
                  },
          backgroundColor: const Color(0xFF4267B2),
          child:
              _perfilController.isLoadingPhoto.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Icon(Icons.photo_camera, color: Colors.white),
        ),
      ),
    );
  }
}
