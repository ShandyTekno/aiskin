import 'package:flutter/material.dart';

import '../models/dummy_models.dart';
import '../theme/app_theme.dart';
import '../widgets/score_card.dart';
import 'result_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = DummyData.history;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          const Text('Analysis History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          const Text('Tap an item to see the full analysis',
              style: TextStyle(fontSize: 14, color: AppColors.grey)),
          const SizedBox(height: 20),
          for (final item in items) ...[
            _HistoryItem(
              result: item,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ResultScreen(result: item, fromHistory: true),
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({required this.result, required this.onTap});

  final AnalysisResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.card(),
        child: Row(
          children: [
            ScoreRing(score: result.score, size: 60, strokeWidth: 6, fontSize: 18),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result.date,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('Skin Score: ${result.score}',
                      style: const TextStyle(fontSize: 13, color: AppColors.grey)),
                  const SizedBox(height: 2),
                  Text('${result.skinType} Skin',
                      style: const TextStyle(fontSize: 13, color: AppColors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
