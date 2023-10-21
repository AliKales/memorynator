// ignore_for_file: use_build_context_synchronously

part of 'note_page_view.dart';

enum NotePageMore {
  delete;
}

mixin MixinNotePage<T extends StatefulWidget> on State<T> {
  late MPerson person;
  List<MNote> notes = [];

  void init(MPerson p) {
    person = p;
  }

  Future<void> afterBuild(params) async {
    final result = await Sql.get(
      Tables.note,
      whereValues: [
        SqlWhere(
          key: "personId",
          value: person.id,
          operator: "=",
          logicalOperators: "AND",
        )
      ],
    );

    if (result == null) return;

    notes = result.map((e) => MNote.fromJson(e)).toList();

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> pushToNote([int? noteIndex]) async {
    MNote? n;
    if (noteIndex != null) n = notes[noteIndex];

    final result = await context.navigatorPush(NewNotePageView(
      person: person,
      note: n,
    ));

    if (result == null) return;
    if (noteIndex != null) {
      setState(() {
        notes[noteIndex] = result;
      });

      return;
    }
    if (result is MNote) _handleNewNote(result);
  }

  void _handleNewNote(MNote note) {
    setState(() {
      notes.add(note);
    });
  }

  Future<void> deleteNote(int index) async {
    final result = await Sql.delete(
      Tables.note,
      whereValues: [
        SqlWhere(
          key: "id",
          value: notes[index].id,
          operator: "=",
          logicalOperators: "",
        )
      ],
    );

    if (result == SqlResult.error) {
      CustomSnackbar.showSuccessSnackBar(
        context,
        text: "Error!",
        isSuccess: false,
      );
      return;
    }

    setState(() {
      notes.removeAt(index);
    });
  }

  void sort(NoteSortFuncs value) {
    if (notes.isEmpty || notes.length == 1) {
      return;
    }

    switch (value) {
      case NoteSortFuncs.aToZ:
        notes.sort(
          (a, b) => a.title!.compareTo(b.title!),
        );
      case NoteSortFuncs.zToA:
        notes.sort(
          (a, b) => b.title!.compareTo(a.title!),
        );
      case NoteSortFuncs.oldest:
        notes.sort(
          (a, b) => a.createdAt.compareTo(b.createdAt),
        );
      case NoteSortFuncs.newest:
        notes.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );
      case NoteSortFuncs.reminder:
        List<MNote> notesReminder =
            notes.where((element) => element.reminder != null).toList();
        notes.removeWhere((element) => element.reminder != null);
        notesReminder.sort(
          (a, b) => a.reminder!.compareTo(b.reminder!),
        );
        notes = notesReminder + notes;
    }

    setState(() {});
  }

  void onMoreAction(int index, NotePageMore notePageMore) {
    switch (notePageMore) {
      case NotePageMore.delete:
        _deletePerson();
    }
  }

  Future<void> _deletePerson() async {
    await Sql.delete(Tables.person, whereValues: [
      SqlWhere(
        key: "id",
        value: person.id,
        operator: "=",
        logicalOperators: "",
      )
    ]);

    await Sql.delete(Tables.note, whereValues: [
      SqlWhere(
        key: "personId",
        value: person.id,
        operator: "=",
        logicalOperators: "",
      )
    ]);

    Navigator.pop(context, person.id);
  }
}
