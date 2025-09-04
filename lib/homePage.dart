import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro006/controladores/controlador.dart';
import 'package:pro006/perfilpage.dart';

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
            style: TextStyle(color: Colors.white),
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
                Get.to(PerfilPage());
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
              onTap: () {},
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
