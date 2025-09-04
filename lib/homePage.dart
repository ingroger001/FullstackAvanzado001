import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro006/controladores/controlador.dart';
import 'package:pro006/perfilpage.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.nombresUsuario.value,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            shadowColor: Colors.black,
            color: Colors.white,
            elevation: 10,
            child: ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF5577B0)),
              title: const Text('Mi Perfil'),
              onTap: () {
                Get.to(const PerfilPage());
              },
            ),
          ),
          Card(
            shadowColor: Colors.black,
            color: Colors.white,
            elevation: 10,
            child: ListTile(
              leading: const Icon(Icons.qr_code, color: Color(0xFF5577B0)),
              title: const Text('Mi QR'),
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (x) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Carnet ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Obx(() {
                          final userData = controller.datosUsuario.value;
                          final imageUrl = userData['urlfoto'] ?? '';
                          final email = userData['email'] ?? '';

                          return Card(
                            elevation: 8,

                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListView(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xFF5577B0),
                                    radius: 65,
                                    child: CircleAvatar(
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
                                    ),
                                  ),
                                  Divider(),
                                  if (email.isNotEmpty)
                                    Center(
                                      child: QrImageView(
                                        data: email,
                                        version: QrVersions.auto,
                                        size: 220.0,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  Divider(),

                                  Container(
                                    padding: EdgeInsets.all(10),
                                    color: Color(0xFF5577B0),
                                    child: Center(
                                      child: Text(
                                        userData['nombres'] ?? 'N/A',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      userData['email'] ?? 'N/A',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(userData['telefono'] ?? 'N/A'),
                                  ),

                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Obx(
            () =>
                controller.hasScannerAccess.value
                    ? Card(
                      shadowColor: Colors.black,
                      color: Colors.white,
                      elevation: 10,
                      child: ListTile(
                        leading: const Icon(
                          Icons.qr_code_scanner,
                          color: Color(0xFF5577B0),
                        ),
                        title: const Text('Escáner'),
                        onTap: () {},
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
          Obx(
            () =>
                controller.isUserAdmin.value
                    ? Card(
                      shadowColor: Colors.black,
                      color: Colors.white,
                      elevation: 10,
                      child: ListTile(
                        leading: const Icon(
                          Icons.group,
                          color: Color(0xFF5577B0),
                        ),
                        title: const Text('Usuarios'),
                        onTap: () {},
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
          Card(
            shadowColor: Colors.black,
            color: Colors.white,
            elevation: 10,
            child: ListTile(
              leading: const Icon(Icons.info, color: Color(0xFF5577B0)),
              title: const Text('Acerca de..'),
              onTap: () {},
            ),
          ),
          const Divider(),
          Card(
            shadowColor: Colors.black,
            color: Colors.white,
            elevation: 10,
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                controller.logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
