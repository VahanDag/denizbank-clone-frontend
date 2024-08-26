import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:flutter/material.dart';

dynamic customBottomSheet(
    {required BuildContext context, required String title, required Widget child, double? height = 0.6}) {
  return showModalBottomSheet(
      isScrollControlled: true, // Bu zaten doğru ayarlanmış.
      context: context,
      builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: height!,
            builder: (context, scrollController) => Container(
              padding: PaddingConstant.paddingAllHigh.copyWith(bottom: 0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(title,
                            style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue)),
                        const Spacer(),
                        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                      ],
                    ),
                    const Divider(),
                    child,
                  ],
                ),
              ),
            ),
          ));
}
