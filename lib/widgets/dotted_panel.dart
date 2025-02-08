import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import '../resources/app_colors.dart';


class DottedPanel extends StatelessWidget {

  final String title;
  final String value;
  final MainAxisAlignment alignment;
  final Color valueColor;

  const DottedPanel({
    super.key,
     required this.title,
    required this.value,
    required this.alignment,
    required this.valueColor
  });


  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        strokeWidth: 2,
        dashPattern: [3],
        color: AppColors.palette2,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            Column(
              children: [
                Text(title,
                    style:
                    const TextStyle(color: AppColors.palette2)),
                Expanded(
                  child: Text(
                      value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(color: valueColor, )
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
