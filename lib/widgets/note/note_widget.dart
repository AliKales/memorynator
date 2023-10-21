import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';
import 'package:memorynator/core/extensions/ext_list.dart';
import 'package:memorynator/core/local_values.dart';
import 'package:memorynator/core/models/m_note.dart';
import 'package:memorynator/theme.dart';

part 'bottom_icons.dart';
part 'note_body.dart';
part 'title.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    super.key,
    required this.note,
    required this.index,
    this.onDelete,
    required this.onTap,
    this.margin,
  });

  final int index;
  final MNote note;
  final VoidCallback? onDelete;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? margin;

  TextStyle _titleTextStyle(BuildContext context) {
    return context.textTheme.headlineSmall!.toBold.toBlack;
  }

  Size _titleSize(BuildContext context) {
    return Utils.measureText(note.title!, _titleTextStyle(context));
  }

  BoxDecoration _decoration(BuildContext context) {
    return BoxDecoration(
      color: _background(context),
      borderRadius: BorderRadius.all(
        Radius.circular(Values.radiusLargeXX),
      ),
    );
  }

  Color _background(BuildContext context) => CustomTheme.colors[index % 6];

  EdgeInsets _padding(BuildContext context) =>
      EdgeInsets.all(Values.paddingWidthSmallX.toDynamicWidth(context));

  @override
  Widget build(BuildContext context) {
    final size = LocalValues.noteSize(context);
    return InkWellNoGlow(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: margin,
        padding: _padding(context),
        decoration: _decoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(context),
            _divider(context),
            _NoteBody(text: note.note!).expanded,
            _BottomIcons(
              onDelete: onDelete,
              showAudio: note.audio.isNotEmptyAndNull,
              showImage: note.images.isNotEmptyAndNull,
              showReminder: note.reminder != null,
            ),
          ],
        ),
      ),
    );
  }

  _Title _title(BuildContext context) =>
      _Title(text: note.title!, textStyle: _titleTextStyle(context));

  SizedBox _divider(BuildContext context) {
    return SizedBox(
      width: _titleSize(context).width,
      child: const Divider(height: 1),
    );
  }
}
