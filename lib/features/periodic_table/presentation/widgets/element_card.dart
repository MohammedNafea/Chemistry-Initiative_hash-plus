import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/periodic_table/data/models/element_model.dart';
import 'package:chemistry_initiative/features/periodic_table/presentation/widgets/element_detail_sheet.dart';

class ElementCard extends StatelessWidget {
  final ElementModel element;

  const ElementCard({super.key, required this.element});

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Nonmetal':
        return Colors.green.shade300;
      case 'Noble Gas':
        return Colors.purple.shade300;
      case 'Alkali Metal':
        return Colors.red.shade300;
      case 'Alkaline Earth Metal':
        return Colors.orange.shade300;
      case 'Metalloid':
        return Colors.teal.shade300;
      case 'Halogen':
        return Colors.blue.shade300;
      case 'Transition Metal':
        return Colors.pink.shade300;
      case 'Post-transition Metal':
        return Colors.indigo.shade300;
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(element.category);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => ElementDetailSheet(element: element),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? color.withValues(alpha: 0.2) : color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${element.atomicNumber}',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              element.symbol,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? color.withValues(alpha: 0.9) : color.withValues(alpha: 0.9), // Darker shade for text?
                // Actually let's use the color itself if it's readable
              ),
            ),
            Text(
              element.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
