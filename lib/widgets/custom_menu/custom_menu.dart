import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';

part 'widgets/menu_widget.dart';

final class CustomListTile<T> {
  final T value;
  final String text;
  final IconData iconData;

  CustomListTile({
    required this.value,
    required this.text,
    required this.iconData,
  });
}

final class CustomMenu {
  static Future<T?> showNote<T>(
    BuildContext context, {
    required String title,
    required TextStyle titleTextStyle,
    required List<CustomListTile<T>> children,
    required final Color background,
    required final EdgeInsets padding,
  }) async {
    EdgeInsets childPadding =
        EdgeInsets.symmetric(vertical: 0.01.toDynamicHeight(context));
    final childTextStyle = context.textTheme.titleLarge!.toBold;

    const iconSize = 30.0;

    Size longestTextSize;

    final longestTile =
        children.reduce((a, b) => a.text.length > b.text.length ? a : b);

    final longestTileSize = Utils.measureText(
      longestTile.text,
      childTextStyle,
    );
    final titleSize = Utils.measureText(title, titleTextStyle);

    if (longestTileSize.width > titleSize.width) {
      longestTextSize = longestTileSize;
    } else {
      longestTextSize = titleSize;
    }

    final position = context.globalPaintBounds!;
    final screenWidth = context.width;
    final screenHeight = context.height;

    double left = position.left;
    double top = position.top;

    final itemWidth = iconSize + longestTextSize.width + padding.horizontal;

    final itemHeight = iconSize +
        longestTextSize.height +
        padding.vertical +
        (childPadding.vertical * children.length);

    final itemRight = left + itemWidth;
    final itemBottom = position.bottom + itemHeight + 50;

    if (itemRight > screenWidth) {
      //we make it plus 10 to avoid mistakes like 41.9
      final overflow = (itemRight - screenWidth) + 10;
      left -= overflow;
    }

    if (itemBottom > screenHeight) {
      final overflow = (itemBottom - screenHeight);
      top -= overflow;
    }

    T? result = await showDialog<T>(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: top * 1.025,
                left: left,
              ),
              child: _MenuWidget(
                background: background,
                padding: padding,
                childPadding: childPadding,
                title: title,
                titleTextStyle: titleTextStyle,
                childTextStyle: childTextStyle,
                iconSize: iconSize,
                children: children,
              ),
            ),
          ],
        );
      },
    );

    return result;
  }
}
