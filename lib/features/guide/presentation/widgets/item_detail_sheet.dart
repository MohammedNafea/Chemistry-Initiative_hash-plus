import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/guide/data/models/household_item.dart';

class ItemDetailSheet extends StatelessWidget {
  final HouseholdItem item;

  const ItemDetailSheet({super.key, required this.item});

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

  String _getSafetyText(SafetyLevel level) {
    switch (level) {
      case SafetyLevel.safe:
        return 'Safe';
      case SafetyLevel.caution:
        return 'Caution';
      case SafetyLevel.danger:
        return 'Danger';
    }
  }

  IconData _getSafetyIcon(SafetyLevel level) {
    switch (level) {
      case SafetyLevel.safe:
        return Icons.check_circle;
      case SafetyLevel.caution:
        return Icons.warning;
      case SafetyLevel.danger:
        return Icons.dangerous;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final safetyColor = _getSafetyColor(item.safetyLevel);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.commonName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.chemicalName,
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: safetyColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: safetyColor),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getSafetyIcon(item.safetyLevel),
                      color: safetyColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getSafetyText(item.safetyLevel).toUpperCase(),
                      style: TextStyle(
                        color: safetyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Formula
          _DetailRow(label: 'Chemical Formula', value: item.formula, isDark: isDark),
          const SizedBox(height: 16),
          
          // Description
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey[700],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Warning
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: safetyColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: safetyColor.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: safetyColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.warning,
                    style: TextStyle(
                      color: isDark ? Colors.grey[300] : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.grey[500] : Colors.grey[600],
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18, 
            fontFamily: 'RobotoMono', // Monospace for formula look
          ),
        ),
      ],
    );
  }
}
