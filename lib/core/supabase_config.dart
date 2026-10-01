import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  SupabaseConfig._();

  /// Kredensial Project Supabase AISKIN
  static const String supabaseUrl = 'https://riwqpkxpnrecfrjvovpi.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_eIbUbEwYDXPXgeZHsNXiKw_d0Bw8fq1';

  /// Memeriksa apakah kredensial Supabase sudah diisi dengan benar
  static bool get isConfigured =>
      supabaseUrl.isNotEmpty &&
      supabaseAnonKey.isNotEmpty &&
      supabaseUrl != 'https://YOUR_PROJECT_ID.supabase.co';

  /// Inisialisasi Supabase
  static Future<void> initialize() async {
    if (!isConfigured) {
      debugPrint('ℹ️ Supabase credentials belum diisi. Berjalan dalam mode demo.');
      return;
    }

    try {
      // ignore: deprecated_member_use
      await Supabase.initialize(
        url: supabaseUrl,
        // ignore: deprecated_member_use
        anonKey: supabaseAnonKey,
      );
      debugPrint('✅ Supabase berhasil terhubung: $supabaseUrl');
    } catch (e) {
      debugPrint('⚠️ Gagal inisialisasi Supabase: $e');
    }
  }

  /// Helper untuk mengakses SupabaseClient dengan aman
  static SupabaseClient? get client {
    if (!isConfigured) return null;
    try {
      return Supabase.instance.client;
    } catch (_) {
      return null;
    }
  }
}
