part of '../custom_menu.dart';

class _MenuWidget extends StatelessWidget {
  const _MenuWidget({
    required this.background,
    required this.padding,
    required this.childPadding,
    required this.title,
    required this.titleTextStyle,
    required this.childTextStyle,
    required this.iconSize,
    required this.children,
  });

  final Color background;
  final EdgeInsets padding;
  final EdgeInsets childPadding;
  final String title;
  final TextStyle titleTextStyle;
  final TextStyle childTextStyle;
  final double iconSize;
  final List<CustomListTile> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.all(
            Radius.circular(Values.radiusMedium),
          ),
        ),
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: titleTextStyle),
            ...List.generate(
              children.length,
              (index) {
                final value = children[index];
                return InkWellNoGlow(
                  onTap: () => Navigator.pop(context, value.value),
                  child: Padding(
                    padding: childPadding,
                    child: _child(value),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _child(CustomListTile<dynamic> value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          value.iconData,
          size: iconSize,
        ),
        Text(value.text.capitalize(), style: childTextStyle),
      ],
    );
  }
}
