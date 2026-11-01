import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class MatchItem {
  final String id;
  final String tournament;
  final String round;
  final String date;
  final String time;
  final String homeTeam;
  final String awayTeam;
  final String homeIcon;
  final String awayIcon;
  final int? homeScore;
  final int? awayScore;
  final String status; // 'live', 'upcoming', 'finished'
  final String? liveMinute;
  final String stadium;
  final String referee;
  final Map<String, dynamic> stats;
  final String sportsFact;

  MatchItem({
    required this.id,
    required this.tournament,
    required this.round,
    required this.date,
    required this.time,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeIcon,
    required this.awayIcon,
    this.homeScore,
    this.awayScore,
    required this.status,
    this.liveMinute,
    required this.stadium,
    required this.referee,
    required this.stats,
    required this.sportsFact,
  });
}

class MatchesTab extends StatefulWidget {
  const MatchesTab({super.key});

  @override
  State<MatchesTab> createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Все матчи', 'В эфире', 'Календарь', 'Завершенные'];

  final List<MatchItem> _matches = [
    MatchItem(
      id: 'm1',
      tournament: 'Чемпионат России',
      round: 'Тур 16',
      date: 'Сегодня',
      time: '19:30',
      homeTeam: 'Зенит',
      awayTeam: 'Спартак',
      homeIcon: '⚽',
      awayIcon: '⚽',
      homeScore: 2,
      awayScore: 1,
      status: 'live',
      liveMinute: '74\'',
      stadium: 'Газпром Арена (Санкт-Петербург)',
      referee: 'С. Карасев',
      stats: {
        'possession': [58, 42],
        'shots': [14, 9],
        'shotsOnTarget': [6, 4],
        'corners': [7, 3],
        'fouls': [11, 14],
      },
      sportsFact: 'Это 165-я встреча соперников в официальных турнирах за всю историю отечественного футбола.',
    ),
    MatchItem(
      id: 'm2',
      tournament: 'Чемпионат России',
      round: 'Тур 16',
      date: 'Сегодня',
      time: '21:00',
      homeTeam: 'Краснодар',
      awayTeam: 'Динамо М',
      homeIcon: '⚽',
      awayIcon: '⚽',
      homeScore: null,
      awayScore: null,
      status: 'upcoming',
      stadium: 'Стадион ФК Краснодар',
      referee: 'А. Сухой',
      stats: {
        'possession': [50, 50],
        'shots': [0, 0],
        'shotsOnTarget': [0, 0],
        'corners': [0, 0],
        'fouls': [0, 0],
      },
      sportsFact: '«Краснодар» в текущем сезоне удерживает лучшую серию по проценту точных передач на домашнем поле.',
    ),
    MatchItem(
      id: 'm3',
      tournament: 'Кубок России',
      round: 'Плей-офф • 1/4',
      date: 'Вчера',
      time: '18:00',
      homeTeam: 'ЦСКА',
      awayTeam: 'Локомотив',
      homeIcon: '⚽',
      awayIcon: '⚽',
      homeScore: 3,
      awayScore: 2,
      status: 'finished',
      stadium: 'ВЭБ Арена (Москва)',
      referee: 'В. Москалев',
      stats: {
        'possession': [52, 48],
        'shots': [16, 12],
        'shotsOnTarget': [8, 5],
        'corners': [6, 5],
        'fouls': [9, 13],
      },
      sportsFact: 'Победный гол был забит на 89-й минуте красивым ударом со штрафного с 25 метров.',
    ),
    MatchItem(
      id: 'm4',
      tournament: 'Чемпионат России',
      round: 'Тур 16',
      date: 'Завтра',
      time: '16:30',
      homeTeam: 'Ростов',
      awayTeam: 'Рубин',
      homeIcon: '⚽',
      awayIcon: '⚽',
      homeScore: null,
      awayScore: null,
      status: 'upcoming',
      stadium: 'Ростов Арена',
      referee: 'Е. Кукуляк',
      stats: {
        'possession': [50, 50],
        'shots': [0, 0],
        'shotsOnTarget': [0, 0],
        'corners': [0, 0],
        'fouls': [0, 0],
      },
      sportsFact: 'В последних 5 очных матчах команд в Ростове-на-Дону забивалось в среднем 2.8 мяча за игру.',
    ),
    MatchItem(
      id: 'm5',
      tournament: 'Чемпионат России',
      round: 'Тур 15',
      date: '27 Окт',
      time: '14:00',
      homeTeam: 'Крылья Советов',
      awayTeam: 'Ахмат',
      homeIcon: '⚽',
      awayIcon: '⚽',
      homeScore: 1,
      awayScore: 0,
      status: 'finished',
      stadium: 'Солидарность Самара Арена',
      referee: 'Р. Сафьян',
      stats: {
        'possession': [49, 51],
        'shots': [10, 11],
        'shotsOnTarget': [4, 3],
        'corners': [5, 4],
        'fouls': [12, 10],
      },
      sportsFact: 'Вратарь самарцев отразил пенальти на добавленных минутах встречи.',
    ),
  ];

  List<MatchItem> get _filteredMatches {
    switch (_selectedFilterIndex) {
      case 1:
        return _matches.where((m) => m.status == 'live').toList();
      case 2:
        return _matches.where((m) => m.status == 'upcoming').toList();
      case 3:
        return _matches.where((m) => m.status == 'finished').toList();
      default:
        return _matches;
    }
  }

  void _showMatchDetails(MatchItem match) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(AppTheme.screenPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceSecondary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      match.tournament,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                    Text(
                      match.round,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    '${match.homeTeam}  ${match.homeScore != null ? "${match.homeScore} : ${match.awayScore}" : "vs"}  ${match.awayTeam}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Статистика матча',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildStatComparisonRow('Владение мячом', '${match.stats['possession'][0]}%', '${match.stats['possession'][1]}%', match.stats['possession'][0] / 100),
                _buildStatComparisonRow('Всего ударов', '${match.stats['shots'][0]}', '${match.stats['shots'][1]}', match.stats['shots'][0] + match.stats['shots'][1] > 0 ? match.stats['shots'][0] / (match.stats['shots'][0] + match.stats['shots'][1]) : 0.5),
                _buildStatComparisonRow('Удары в створ', '${match.stats['shotsOnTarget'][0]}', '${match.stats['shotsOnTarget'][1]}', match.stats['shotsOnTarget'][0] + match.stats['shotsOnTarget'][1] > 0 ? match.stats['shotsOnTarget'][0] / (match.stats['shotsOnTarget'][0] + match.stats['shotsOnTarget'][1]) : 0.5),
                _buildStatComparisonRow('Угловые', '${match.stats['corners'][0]}', '${match.stats['corners'][1]}', match.stats['corners'][0] + match.stats['corners'][1] > 0 ? match.stats['corners'][0] / (match.stats['corners'][0] + match.stats['corners'][1]) : 0.5),
                _buildStatComparisonRow('Фолы', '${match.stats['fouls'][0]}', '${match.stats['fouls'][1]}', match.stats['fouls'][0] + match.stats['fouls'][1] > 0 ? match.stats['fouls'][0] / (match.stats['fouls'][0] + match.stats['fouls'][1]) : 0.5),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceSecondary,
                    borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline_rounded, color: AppTheme.accentLime, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          match.sportsFact,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.stadium_rounded, color: AppTheme.textMuted, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        match.stadium,
                        style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.sports_rounded, color: AppTheme.textMuted, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Главный судья: ${match.referee}',
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: AppTheme.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: AppTheme.onAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                      ),
                    ),
                    child: const Text(
                      'Закрыть',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatComparisonRow(String title, String homeVal, String awayVal, double ratio) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(homeVal, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              Text(title, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
              Text(awayVal, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Row(
              children: [
                Expanded(
                  flex: (ratio * 100).toInt().clamp(1, 99),
                  child: Container(height: 4, color: AppTheme.primary),
                ),
                const SizedBox(width: 2),
                Expanded(
                  flex: ((1 - ratio) * 100).toInt().clamp(1, 99),
                  child: Container(height: 4, color: AppTheme.surfaceSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppTheme.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Матчи Лиги',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceSecondary,
                  borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.calendar_month_rounded, size: 16, color: AppTheme.primary),
                    SizedBox(width: 6),
                    Text(
                      'Сезон 2026/27',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Расписание, результаты и спортивная статистика',
            style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 18),

          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_filters.length, (index) {
                final isSelected = _selectedFilterIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(_filters[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedFilterIndex = index);
                      }
                    },
                    selectedColor: AppTheme.primary,
                    backgroundColor: AppTheme.surfaceCard,
                    labelStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppTheme.onAccent : AppTheme.textSecondary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                      side: BorderSide(
                        color: isSelected ? AppTheme.primary : AppTheme.surfaceBorder,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 18),

          // Matches list
          if (_filteredMatches.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: const [
                  Icon(Icons.sports_soccer_rounded, size: 48, color: AppTheme.textMuted),
                  SizedBox(height: 12),
                  Text(
                    'Матчи в этой категории не найдены',
                    style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            )
          else
            ..._filteredMatches.map((m) => _buildMatchCard(m)),
        ],
      ),
    );
  }

  Widget _buildMatchCard(MatchItem match) {
    final isLive = match.status == 'live';
    final isFinished = match.status == 'finished';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(
          color: isLive ? AppTheme.accentLime.withAlpha(120) : AppTheme.surfaceBorder,
          width: isLive ? 1.5 : 1.0,
        ),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceSecondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.sports_soccer, size: 14, color: AppTheme.primary),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${match.tournament} • ${match.round}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                // Status badge
                if (isLive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.accentLime,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppTheme.onAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'LIVE ${match.liveMinute ?? ""}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.onAccent,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (isFinished)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceSecondary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'ЗАВЕРШЕН',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withAlpha(30),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${match.date}, ${match.time}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Teams and score
            Row(
              children: [
                // Home team
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceSecondary,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.surfaceBorder),
                        ),
                        child: const Center(
                          child: Icon(Icons.shield_rounded, color: AppTheme.primary, size: 26),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        match.homeTeam,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Score / Time
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      if (match.homeScore != null)
                        Text(
                          '${match.homeScore} : ${match.awayScore}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: isLive ? AppTheme.accentLime : AppTheme.textPrimary,
                            letterSpacing: 2,
                          ),
                        )
                      else
                        Text(
                          match.time,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        isLive ? 'Идет игра' : (isFinished ? 'Итог' : match.date),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Away team
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceSecondary,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.surfaceBorder),
                        ),
                        child: const Center(
                          child: Icon(Icons.shield_outlined, color: AppTheme.primary, size: 26),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        match.awayTeam,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Bottom action button (>= 48 dp height, 12 dp border radius)
            SizedBox(
              width: double.infinity,
              height: AppTheme.buttonHeight,
              child: ElevatedButton.icon(
                onPressed: () => _showMatchDetails(match),
                icon: const Icon(Icons.insights_rounded, size: 18),
                label: const Text(
                  'Спортивная статистика и факты',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.surfaceSecondary,
                  foregroundColor: AppTheme.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                    side: const BorderSide(color: AppTheme.surfaceBorder),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

