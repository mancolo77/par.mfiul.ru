import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_state_provider.dart';
import '../../services/quiz_repository.dart';
import '../../theme/app_theme.dart';

class MyProgressTab extends StatelessWidget {
  final QuizRepository repository;

  const MyProgressTab({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameStateProvider>();
    final fanLevels = repository.fanLevels;
    final currentLevel = gameState.getCurrentFanLevel(fanLevels);
    final nextLevel = gameState.getNextFanLevel(fanLevels);
    final progressToNext = gameState.getLevelProgress(fanLevels);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppTheme.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Screen Title
          const Text(
            'Мой прогресс',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Спортивный ранг, достижения и виртуальные значки',
            style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 18),

          // 1. Ранг и шкала прогресса (Лаймовый акцент #C7ED4C)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              border: Border.all(color: AppTheme.surfaceBorder),
              boxShadow: AppTheme.cardShadow,
              gradient: const LinearGradient(
                colors: [
                  AppTheme.surfaceCard,
                  Color(0xFF1E2D3F),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceSecondary,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.accentLime, width: 2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.military_tech_rounded,
                          color: AppTheme.accentLime,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppTheme.accentLime,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'УРОВЕНЬ ${currentLevel.level}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.onAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentLevel.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            '${gameState.xp} XP опыта лиги',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Шкала прогресса (#C7ED4C)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Прогресс ранга: ${(progressToNext * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      nextLevel != null ? 'След.: ${nextLevel.name}' : 'Макс. ранг',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progressToNext.clamp(0.0, 1.0),
                    minHeight: 10,
                    backgroundColor: AppTheme.surfaceSecondary,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentLime),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceSecondary,
                    borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.stars_rounded, color: AppTheme.primary, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Баланс: ${gameState.coins} баллов (только для уровней и значков)',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. Статистика (4 карточки #192434)
          const Text(
            'Спортивная статистика',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.45,
            children: [
              _buildStatCard(
                icon: Icons.quiz_rounded,
                label: 'Викторин пройдено',
                value: '${gameState.quizzesCompleted}',
                accentColor: AppTheme.primary,
              ),
              _buildStatCard(
                icon: Icons.spellcheck_rounded,
                label: 'Слов отгадано',
                value: '${gameState.wordsSolved}',
                accentColor: AppTheme.accentLime,
              ),
              _buildStatCard(
                icon: Icons.pie_chart_outline_rounded,
                label: 'Точность ответов',
                value: '${gameState.accuracyPercentage}%',
                accentColor: AppTheme.primary,
              ),
              _buildStatCard(
                icon: Icons.local_fire_department_rounded,
                label: 'Лучшая серия',
                value: '${gameState.bestStreak}',
                accentColor: AppTheme.accentLime,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 3. Виртуальные значки и достижения
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Виртуальные значки',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                '${repository.loyaltyStore.where((i) => gameState.purchasedRewardIds.contains(i.id)).length} из ${repository.loyaltyStore.length}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentLime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Badge list
          ...repository.loyaltyStore.map((reward) {
            final isUnlocked = gameState.purchasedRewardIds.contains(reward.id);
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceCard,
                borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                border: Border.all(
                  color: isUnlocked ? AppTheme.accentLime.withAlpha(100) : AppTheme.surfaceBorder,
                ),
                boxShadow: AppTheme.cardShadow,
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isUnlocked
                          ? AppTheme.accentLime.withAlpha(30)
                          : AppTheme.surfaceSecondary,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isUnlocked ? AppTheme.accentLime : AppTheme.surfaceBorder,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        QuizRepository.getIconData(reward.icon),
                        color: isUnlocked ? AppTheme.accentLime : AppTheme.textMuted,
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reward.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          reward.description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.stars_rounded, size: 14, color: AppTheme.primary),
                            const SizedBox(width: 4),
                            Text(
                              '${reward.cost} баллов',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (isUnlocked)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.accentLime.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.check_circle_rounded, size: 14, color: AppTheme.accentLime),
                          SizedBox(width: 4),
                          Text(
                            'Открыт',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.accentLime,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: gameState.coins >= reward.cost
                            ? () {
                                final success = gameState.purchaseReward(reward);
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppTheme.surfaceCard,
                                      content: Text(
                                        'Значок «${reward.title}» разблокирован!',
                                        style: const TextStyle(color: AppTheme.accentLime),
                                      ),
                                    ),
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: AppTheme.onAccent,
                          disabledBackgroundColor: AppTheme.surfaceSecondary,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                          ),
                        ),
                        child: const Text(
                          'Получить',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),

          // 4. Информационный дисклеймер
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceSecondary,
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              border: Border.all(color: AppTheme.surfaceBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.verified_user_rounded, color: AppTheme.primary, size: 22),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Баллы служат только для уровней и виртуальных значков, без покупки и обмена на деньги или призы. Приложение носит сугубо спортивно-познавательный характер.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: AppTheme.surfaceBorder),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              Icon(icon, color: accentColor, size: 20),
            ],
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
