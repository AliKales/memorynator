part of '../audio_widget.dart';

class _IconDone extends StatelessWidget {
  const _IconDone({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onTap,
      icon: const Icon(Icons.done),
    ).animate().slide(
          duration: 100.toDuration,
          begin: const Offset(-2, 0),
        );
  }
}
