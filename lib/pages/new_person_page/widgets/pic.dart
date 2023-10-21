part of '../new_person_page_view.dart';

class _Pic extends StatelessWidget {
  const _Pic({
    required this.onPicChange,
    this.randomAvatar,
    required this.onSubmit,
    required this.onFromGallery,
    this.imagePath,
  });

  final ValueChanged<String> onPicChange;
  final String? randomAvatar;
  final VoidCallback onSubmit;
  final VoidCallback onFromGallery;
  final String? imagePath;

  double _getImageSize(BuildContext context) {
    return LocalValues.picSize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PictureImage(
          size: _getImageSize(context),
          randomAvatarText: randomAvatar,
          imagePath: imagePath,
        ),
        context.sizedBox(width: Values.paddingWidthSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CTextField(
              labelText: "Picture Nick",
              onChanged: onPicChange,
            ),
            TextButton(
              onPressed: onSubmit,
              child: const Text("SUBMIT"),
            ).right,
            const Text("OR"),
            TextButton(
              onPressed: onFromGallery,
              child: const Text("FROM GALLERY"),
            ),
          ],
        ).expanded,
      ],
    );
  }
}
