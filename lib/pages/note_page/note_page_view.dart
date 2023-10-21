import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';
import 'package:memorynator/core/local_values.dart';
import 'package:memorynator/core/models/m_note.dart';
import 'package:memorynator/core/models/m_person.dart';
import 'package:memorynator/core/sql.dart';
import 'package:memorynator/pages/new_note_page/new_note_page_view.dart';
import 'package:memorynator/widgets/picture_image.dart';

import 'widgets/notes.dart';

part 'mixin_note_page.dart';
part 'widgets/info_sort.dart';
part 'widgets/title.dart';

class NotePageView extends StatefulWidget {
  const NotePageView({super.key, required this.person});

  final MPerson person;

  @override
  State<NotePageView> createState() => _NotePageViewState();
}

class _NotePageViewState extends State<NotePageView> with MixinNotePage {
  @override
  void initState() {
    super.initState();
    init(widget.person);
    context.afterBuild(afterBuild);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _fAB(),
    );
  }

  FloatingActionButton _fAB() {
    return FloatingActionButton.extended(
      onPressed: pushToNote,
      label: const Text("Add note"),
      icon: const Icon(Icons.add),
    );
  }

  Widget _body() {
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: Values.paddingPage(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.sizedBox(height: Values.paddingHeightSmallXX),
              _Title(widget.person),
              const Divider(),
              _InfoSort(onSort: sort),
              Notes(
                notes: notes,
                onDelete: deleteNote,
                onTap: (value) => pushToNote(value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      actions: [
        MenuWidget(
          items: NotePageMore.values,
          item: (index, item) {
            return Text(item.name);
          },
          onClick: onMoreAction,
          child: const Icon(Icons.more_horiz),
        ),
      ],
    );
  }
}
