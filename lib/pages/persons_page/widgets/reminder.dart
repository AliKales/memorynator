part of '../persons_page_view.dart';

class _Reminder extends StatelessWidget {
  const _Reminder({
    required this.notesReminder,
    required this.onTap,
    required this.onPersonTap,
  });

  final List<MNote> notesReminder;
  final ValueChanged<int> onTap;
  final ValueChanged<int> onPersonTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          notesReminder.length,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleWidget(
                notesReminder[index].person!,
                onTap: () => onPersonTap.call(index),
              ),
              context.sizedBox(height: Values.paddingHeightSmallXX),
              NoteWidget(
                note: notesReminder[index],
                index: index,
                onTap: () => onTap.call(index),
                margin: const EdgeInsets.only(right: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget(
    this.person, {
    required this.onTap,
  });

  final MPerson person;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double maxSize = LocalValues.noteSize(context);
    double padding = Values.paddingWidthSmallXX.toDynamicWidth(context);
    double picSize = 0.1.toDynamicWidth(context);
    double textSize = maxSize - (picSize - padding);
    return InkWellNoGlow(
      onTap: onTap,
      child: Row(
        children: [
          PictureImage(
            size: picSize,
            randomAvatarText: person.randomAvatarText,
            imagePath: person.imagePath,
            name: person.name,
          ),
          SizedBox(
            width: padding,
          ),
          SizedBox(
            width: textSize,
            child: Text(
              person.name ?? "-",
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: context.textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
