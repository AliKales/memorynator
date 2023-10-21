import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memorynator/core/extensions/ext_list.dart';
import 'package:memorynator/core/local_values.dart';
import 'package:memorynator/core/models/m_note.dart';
import 'package:memorynator/core/models/m_person.dart';
import 'package:memorynator/core/sql.dart';
import 'package:memorynator/pages/new_note_page/new_note_page_view.dart';
import 'package:memorynator/pages/new_person_page/new_person_page_view.dart';
import 'package:memorynator/pages/note_page/note_page_view.dart';
import 'package:memorynator/widgets/note/note_widget.dart';

import '../../widgets/picture_image.dart';

part 'mixin_persons_page.dart';
part 'widgets/grid_view.dart';
part 'widgets/person_widget.dart';
part 'widgets/reminder.dart';

class PersonsPageView extends StatefulWidget {
  const PersonsPageView({super.key});

  @override
  State<PersonsPageView> createState() => _PersonsPageViewState();
}

class _PersonsPageViewState extends State<PersonsPageView>
    with _MixinPersonsPage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _floating(),
      body: _body(),
    );
  }

  Padding _body() {
    return Padding(
      padding: Values.paddingPage(context),
      child: persons.isEmptyOrNull
          ? const _NoData()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (notesReminder.isNotEmptyAndNull) ...[
                    const _Title(text: "Reminder"),
                    _Reminder(
                      notesReminder: notesReminder,
                      onTap: onNoteTap,
                      onPersonTap: onPersonTap,
                    ),
                    const Divider(
                      height: 30,
                    ),
                  ],
                  if (persons.isNotEmptyAndNull) const _Title(text: "Persons"),
                  _GridView(onPersonTap: onPersonTap, persons: persons),
                ],
              ),
            ),
    );
  }

  FloatingActionButton _floating() {
    return FloatingActionButton(
      onPressed: onFABTap,
      child: const Icon(Icons.add),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Memorynator"),
      elevation: 0,
    );
  }
}

class _NoData extends StatelessWidget {
  const _NoData();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/svg/no_data.svg",
      width: 0.3.toDynamicWidth(context),
    ).center;
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineSmall!.toBold,
    );
  }
}
