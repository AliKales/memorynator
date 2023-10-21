part of 'c_date_picker.dart';

class _DateText extends StatelessWidget {
  const _DateText(this.text, {this.error});

  final String text;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          error ?? text,
          style: context.textTheme.headlineMedium!.copyWith(
            color: error == null ? Colors.white : context.colorScheme.error,
          ),
        ).expanded,
        const Icon(Icons.date_range)
      ],
    );
  }
}
