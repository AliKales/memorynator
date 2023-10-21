part of 'images_widget.dart';

class _Image extends StatelessWidget {
  const _Image({this.imagePath, this.onDelete});

  final String? imagePath;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.maxFinite,
          width: 0.3.toDynamicWidth(context),
          margin:
              EdgeInsets.all(Values.paddingWidthSmallX.toDynamicWidth(context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Values.radiusSmall)),
            border: Border.all(
              color: context.colorScheme.primary.withOpacity(0.3),
            ),
            image: imagePath.isNotEmptyAndNull
                ? DecorationImage(
                    image: FileImage(File(imagePath!)), fit: BoxFit.cover)
                : null,
          ),
          child: const _AddImage().toVisible(imagePath.isNotEmptyAndNull),
        ),
        if (onDelete != null)
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
      ],
    );
  }
}

class _AddImage extends StatelessWidget {
  const _AddImage();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add),
        Text("Add Image"),
      ],
    );
  }
}
