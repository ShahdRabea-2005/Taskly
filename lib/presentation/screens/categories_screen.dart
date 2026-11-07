import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Box tasksBox;

  @override
  void initState() {
    super.initState();
    tasksBox = Hive.box('tasksBox');
  }

  @override
  Widget build(BuildContext context) {
    List tasks = tasksBox.values.toList();

    Map<String, Map<String, int>> getCategoryStats() {
      Map<String, Map<String, int>> stats = {
        'Personal': {'total': 0, 'pending': 0},
        'Study': {'total': 0, 'pending': 0},
        'Work': {'total': 0, 'pending': 0},
        'Health': {'total': 0, 'pending': 0},
        'Other': {'total': 0, 'pending': 0},
      };

      for (var task in tasks) {
        String cat = task['category'] ?? 'Work';
        bool isCompleted = task['isCompleted'] ?? false;
        if (stats.containsKey(cat)) {
          stats[cat]!['total'] = (stats[cat]!['total']! + 1);
          if (!isCompleted) {
            stats[cat]!['pending'] = (stats[cat]!['pending']! + 1);
          }
        }
      }
      return stats;
    }

    final stats = getCategoryStats();

    return Scaffold(
      backgroundColor: const Color(0xFF1F1E31),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Tap a category to see its tasks.',
                style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    _buildCategoryCard(
                      'Personal',
                      Icons.favorite_border,
                      stats['Personal']!['total']!,
                      stats['Personal']!['pending']!,
                    ),
                    _buildCategoryCard(
                      'Study',
                      Icons.menu_book_outlined,
                      stats['Study']!['total']!,
                      stats['Study']!['pending']!,
                    ),
                    _buildCategoryCard(
                      'Work',
                      Icons.work_outline,
                      stats['Work']!['total']!,
                      stats['Work']!['pending']!,
                    ),
                    _buildCategoryCard(
                      'Health',
                      Icons.eco_outlined,
                      stats['Health']!['total']!,
                      stats['Health']!['pending']!,
                    ),
                    _buildCategoryCard(
                      'Other',
                      Icons.folder_outlined,
                      stats['Other']!['total']!,
                      stats['Other']!['pending']!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    String title,
    IconData icon,
    int total,
    int pending,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2C44), // لون الكارت الداكن المتناسق
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF3E3D5C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$total tasks · $pending pending',
            style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }
}
