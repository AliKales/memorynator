part of '../persons_page_view.dart';

class _PersonWidget extends StatelessWidget {
  const _PersonWidget({
    required this.textStyle,
    required this.profilePicWidth,
    required this.person,
    this.onTap,
  });

  final TextStyle textStyle;
  final double profilePicWidth;

  final MPerson person;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWellNoGlow(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PictureImage(
            randomAvatarText: person.randomAvatarText,
            size: profilePicWidth,
            name: person.name,
            imagePath: person.imagePath,
          ),
          Text(
            person.name ?? "-",
            style: textStyle,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
        ],
      ),
    );
  }
}
