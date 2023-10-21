part of '../note_page_view.dart';

enum NoteSortFuncs {
  aToZ(Icons.sort_by_alpha_outlined),
  zToA(Icons.ac_unit_sharp),
  oldest(Icons.sports_cricket_rounded),
  newest(Icons.network_wifi_sharp),
  reminder(Icons.alarm);

  final IconData iconData;

  const NoteSortFuncs(this.iconData);
}

class _InfoSort extends StatelessWidget {
  const _InfoSort({required this.onSort});

  final ValueChanged<NoteSortFuncs> onSort;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Notes",
          style: context.textTheme.titleLarge!.toBold,
        ),
        _SortWidget(onTap: onSort),
      ],
    );
  }
}

class _SortWidget extends StatelessWidget {
  const _SortWidget({
    required this.onTap,
  });

  final ValueChanged<NoteSortFuncs> onTap;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: List.generate(
        NoteSortFuncs.values.length,
        (index) {
          NoteSortFuncs value = NoteSortFuncs.values[index];
          return MenuItemButton(
            child: Text(value.name),
            onPressed: () => onTap.call(value),
          );
        },
      ),
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.sort),
        );
      },
    );
  }
}
