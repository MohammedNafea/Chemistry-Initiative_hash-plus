import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/guide/data/models/household_item.dart';
import 'package:chemistry_initiative/features/guide/data/repositories/household_item_repository.dart';
import 'package:chemistry_initiative/features/guide/presentation/widgets/item_detail_sheet.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class HouseholdItemsScreen extends StatefulWidget {
  const HouseholdItemsScreen({super.key});

  @override
  State<HouseholdItemsScreen> createState() => _HouseholdItemsScreenState();
}

class _HouseholdItemsScreenState extends State<HouseholdItemsScreen> {
  late List<HouseholdItem> _allItems;
  List<HouseholdItem> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localizations = AppLocalizations.of(context)!;
    _allItems = HouseholdItemRepository.getItems(localizations);
    if (_filteredItems.isEmpty && _searchController.text.isEmpty) {
      _filteredItems = _allItems;
    }
  }

  void _filterItems(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = _allItems;
      });
    } else {
      setState(() {
        _filteredItems = _allItems.where((item) {
          final commonName = item.commonName.toLowerCase();
          final chemicalName = item.chemicalName.toLowerCase();
          final search = query.toLowerCase();
          return commonName.contains(search) || chemicalName.contains(search);
        }).toList();
      });
    }
  }

  Color _getSafetyColor(SafetyLevel level) {
    switch (level) {
      case SafetyLevel.safe:
        return Colors.green;
      case SafetyLevel.caution:
        return Colors.amber.shade700;
      case SafetyLevel.danger:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.whatsInThis),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchPlaceholder, // Reuse search placeholder
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // List
          Expanded(
            child: ListView.separated(
              itemCount: _filteredItems.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: _getSafetyColor(item.safetyLevel).withValues(alpha: 0.2),
                    child: Icon(
                      Icons.science,
                      color: _getSafetyColor(item.safetyLevel),
                    ),
                  ),
                  title: Text(
                    item.commonName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.chemicalName),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => ItemDetailSheet(item: item),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
