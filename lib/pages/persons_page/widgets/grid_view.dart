part of '../persons_page_view.dart';

class _GridView extends StatelessWidget {
  const _GridView({required this.onPersonTap, required this.persons});

  final ValueChanged<int> onPersonTap;
  final List<MPerson> persons;

  @override
  Widget build(BuildContext context) {
    final profilePicWidth = 0.2.toDynamicWidth(context);
    final textStyle = context.textTheme.titleLarge!.toBold;
    final textStyleSize = Utils.measureText("text", textStyle);
    final additionalSpace = 0.04.toDynamicHeight(context);
    final height = profilePicWidth + textStyleSize.height + additionalSpace;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: height,
        mainAxisSpacing: Values.paddingPageValue.toDynamicWidth(context),
        crossAxisSpacing: Values.paddingPageValue.toDynamicWidth(context),
      ),
      itemCount: persons.length,
      itemBuilder: (context, index) => _PersonWidget(
        onTap: () => onPersonTap.call(index),
        textStyle: textStyle,
        profilePicWidth: profilePicWidth,
        person: persons[index],
      ),
    );
  }
}
