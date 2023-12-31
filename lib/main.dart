import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clinica_app_taller/route/routes_app.dart';
import 'package:clinica_app_taller/services/services.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const AppState());
} 
class AppState extends StatelessWidget {
  const AppState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => UserService()),
      ChangeNotifierProvider(create: (_) => EmergencyService()),
      ChangeNotifierProvider(create: (_) => HistoriaService()),
      ChangeNotifierProvider(create: (_) => FacialService()),
    ], 
    child: const MyApp() 
    );
  }
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
    );
  }
}