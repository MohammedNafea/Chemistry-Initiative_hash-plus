import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/guide/data/models/household_item.dart';
import 'package:chemistry_initiative/features/guide/data/repositories/household_item_repository.dart';
import 'package:chemistry_initiative/features/guide/presentation/widgets/item_detail_sheet.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:chemistry_initiative/core/theme/app_colors.dart';

class HouseholdItemsScreen extends StatefulWidget {
  const HouseholdItemsScreen({super.key});

  @override
  State<HouseholdItemsScreen> createState() => _HouseholdItemsScreenState();
}

class _HouseholdItemsScreenState extends State<HouseholdItemsScreen> {
  late List<HouseholdItem> _allItems;
  List<HouseholdItem> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  void _openDetail(HouseholdItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ItemDetailSheet(item: item),
    );
  }

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
                hintText: AppLocalizations.of(context)!.searchPlaceholder,
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: isDark ? AppColors.labSurface : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),

          // Responsive Content
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Grid View for Tablet/Desktop
                  int crossAxisCount = constraints.maxWidth > 1200 ? 4 : 2;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => _openDetail(item),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: _getSafetyColor(
                                    item.safetyLevel,
                                  ).withValues(alpha: 0.1),
                                  child: Icon(
                                    Icons.science_rounded,
                                    color: _getSafetyColor(item.safetyLevel),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.commonName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        item.chemicalName,
                                        style: theme.textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  // List View for Mobile
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _filteredItems.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, indent: 72),
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getSafetyColor(
                            item.safetyLevel,
                          ).withValues(alpha: 0.1),
                          child: Icon(
                            Icons.science_rounded,
                            color: _getSafetyColor(item.safetyLevel),
                          ),
                        ),
                        title: Text(
                          item.commonName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(item.chemicalName),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        ),
                        onTap: () => _openDetail(item),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
