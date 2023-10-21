part of 'note_widget.dart';

class _NoteBody extends StatelessWidget {
  const _NoteBody({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.titleMedium!.toBold.toBlack,
      maxLines: null,
      overflow: TextOverflow.fade,
    );
  }
}
