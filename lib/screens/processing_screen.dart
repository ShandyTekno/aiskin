import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/dummy_models.dart';
import '../theme/app_theme.dart';
import '../widgets/aiskin_logo.dart';
import 'result_screen.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({super.key, this.imageBytes});

  final Uint8List? imageBytes;

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    // Simulate AI model inference delay
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            result: DummyData.latest,
            imageBytes: widget.imageBytes,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  Widget _buildScanTarget() {
    if (widget.imageBytes != null) {
      return Container(
        width: 170,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.purple, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.memory(widget.imageBytes!, fit: BoxFit.cover),
            ),
            // Glowing scanner beam
            AnimatedBuilder(
              animation: _anim,
              builder: (context, _) {
                return Positioned(
                  top: _anim.value * 160,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.purple,
                          Colors.white,
                          AppColors.purple,
                          Colors.transparent,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.purple.withValues(alpha: 0.8),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return const AiskinLogo(size: 100);
  }

  Widget _ring(double phase) {
    final t = (_anim.value + phase) % 1.0;
    final size = 160 + 90 * t;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.purple.withValues(alpha: (1 - t) * 0.35),
          width: 2,
        ),
        color: AppColors.purple.withValues(alpha: (1 - t) * 0.05),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 260,
                  height: 260,
                  child: AnimatedBuilder(
                    animation: _anim,
                    builder: (context, child) => Stack(
                      alignment: Alignment.center,
                      children: [
                        _ring(0),
                        _ring(0.5),
                        child!,
                      ],
                    ),
                    child: _buildScanTarget(),
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Analyzing your skin...',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'AI is inspecting acne, oiliness, and skin texture',
                  style: TextStyle(fontSize: 14, color: AppColors.grey),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: AppColors.softBlue,
                      valueColor: AlwaysStoppedAnimation(AppColors.purple),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
