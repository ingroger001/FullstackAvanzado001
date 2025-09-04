import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro006/MyApp.dart';
import 'package:pro006/controladores/controlador.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Definimos la URL y la API Key para la conexión a Supabase
const String supabaseUrl =
    'https://voxiaunrkplxibrzyhhz.supabase.co/rest/v1/personas';
const String supabaseApiKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZveGlhdW5ya3BseGlicnp5aGh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY5OTc5NTMsImV4cCI6MjA3MjU3Mzk1M30.UO8j61KHKhqltznEK-RK4fQrb5JOSOBA7BoHNuHMLNY';

void main() async {
  await Supabase.initialize(
    url: "https://voxiaunrkplxibrzyhhz.supabase.co",
    anonKey: supabaseApiKey,
  );
  Get.put(LoginController());
  runApp(const MyApp());
}
