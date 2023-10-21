part of '../note_page_view.dart';

class _Title extends StatelessWidget {
  const _Title(this.person);

  final MPerson person;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PictureImage(
          size: LocalValues.picSize(context),
          randomAvatarText: person.randomAvatarText,
          imagePath: person.imagePath,
          name: person.name,
        ),
        context.sizedBox(width: Values.paddingWidthSmallX),
        Expanded(
          child: Text(person.name ?? "-",
                  style: context.textTheme.headlineMedium!.toBold)
              .center,
        ),
      ],
    );
  }
}
