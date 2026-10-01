import 'package:flutter/material.dart';

import 'core/supabase_config.dart';
import 'screens/splash_screen.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase (jika kredensial sudah diisi di SupabaseConfig)
  await SupabaseConfig.initialize();

  // Sinkronisasi data user aktif
  AuthService.syncUserFromSupabase();

  runApp(const AiskinApp());
}

class AiskinApp extends StatelessWidget {
  const AiskinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AISKIN',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
