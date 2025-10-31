import 'package:flutter/material.dart';
import 'package:flutter_app/core/style/index.dart';
import 'package:flutter_app/widgets/common_widget.dart';

/// Example screen demonstrating how to use CommonSearchField
class CommonSearchFieldExample extends StatefulWidget {
  const CommonSearchFieldExample({super.key});

  @override
  State<CommonSearchFieldExample> createState() =>
      _CommonSearchFieldExampleState();
}

class _CommonSearchFieldExampleState extends State<CommonSearchFieldExample> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'CommonSearchField Example',
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic search field
            const Text(
              'Basic Search Field:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            const CommonSearchField(hintText: 'Tìm kiếm cơ bản...'),

            const SizedBox(height: 24),

            // Search field with controller
            const Text(
              'Search Field with Controller:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            CommonSearchField(
              hintText: 'Tìm kiếm với controller...',
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Search field with custom height
            const Text(
              'Search Field with Custom Height:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            const CommonSearchField(
              hintText: 'Tìm kiếm với chiều cao tùy chỉnh...',
              height: 60,
            ),

            const SizedBox(height: 24),

            // Search field disabled
            const Text(
              'Search Field Disabled:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            const CommonSearchField(
              hintText: 'Tìm kiếm bị vô hiệu hóa...',
              enabled: false,
            ),

            const SizedBox(height: 24),

            // Display search query
            if (_searchQuery.isNotEmpty) ...[
              const Text(
                'Search Query:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _searchQuery,
                  style: const TextStyle(fontSize: 14, color: AppColors.black),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
