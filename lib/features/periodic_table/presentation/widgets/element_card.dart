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
    final categoryColor = _getCategoryColor(element.category);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark
              ? categoryColor.withValues(alpha: 0.15)
              : categoryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: categoryColor.withValues(alpha: 0.6),
            width: 2,
          ),
          boxShadow: [
            if (isDark)
              BoxShadow(
                color: categoryColor.withValues(alpha: 0.3),
                blurRadius: 10,
                spreadRadius: -2,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${element.atomicNumber}',
              style: TextStyle(
                fontSize: MediaQuery.sizeOf(context).width < 600 ? 9 : 10,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  element.symbol,
                  style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).width < 600 ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? Colors.white
                        : categoryColor.withValues(alpha: 0.8),
                    shadows: [
                      if (isDark)
                        Shadow(
                          color: categoryColor.withValues(alpha: 0.5),
                          blurRadius: 8,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                element.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
