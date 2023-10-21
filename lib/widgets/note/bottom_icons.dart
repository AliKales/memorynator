part of 'note_widget.dart';

class _BottomIcons extends StatelessWidget {
  const _BottomIcons({
    required this.onDelete,
    this.showImage = false,
    this.showReminder = false,
    this.showAudio = false,
  });

  final VoidCallback? onDelete;
  final bool showImage;
  final bool showReminder;
  final bool showAudio;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          iconTheme: const IconThemeData(
        color: Colors.black,
      )),
      child: Row(
        children: [
          const Icon(Icons.photo).toVisible(!showImage),
          const Icon(Icons.alarm).toVisible(!showReminder),
          const Icon(Icons.record_voice_over).toVisible(!showAudio),
          const Spacer(),
          if (onDelete != null) _DeleteButton(onDelete!),
        ],
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton(this.onTap);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      constraints: const BoxConstraints(
        minHeight: 0,
        minWidth: 0,
      ),
      padding: EdgeInsets.zero,
      icon: Icon(Icons.delete_forever, color: context.colorScheme.error),
    );
  }
}
