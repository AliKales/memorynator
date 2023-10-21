part of 'note_widget.dart';

class _Title extends StatelessWidget {
  const _Title({required this.text, required this.textStyle});

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
