// ignore_for_file: use_build_context_synchronously

part of 'persons_page_view.dart';

mixin _MixinPersonsPage<T extends StatefulWidget> on State<T> {
  List<MPerson> persons = [];

  List<MNote> notesReminder = [];

  @override
  void initState() {
    super.initState();
    context.afterBuild(_afterBuild);
  }

  Future<void> _afterBuild(params) async {
    final result = await Sql.get(Tables.person);

    if (result == null) return;

    final notes = await Sql.get(Tables.note,
        limit: 10,
        orderBy: "reminder ASC",
        whereValues: [
          SqlWhere(
            key: "reminder",
            value: "NULL",
            operator: "!=",
            logicalOperators: "AND",
          )
        ]);
    List<MPerson> notePersons = [];

    notesReminder = await Future.wait(notes!.map((e) async {
      MNote n = MNote.fromJson(e);

      final r =
          notePersons.firstWhereOrNull((element) => element.id == n.personId);

      if (r != null) {
        n.person = r;
      } else {
        final newPerson = await _getPerson(n.personId);
        notePersons.add(newPerson);
        n.person = newPerson;
      }

      return n;
    }).toList());

    persons = result.map((e) => MPerson.fromJson(e)).toList();
    setState(() {});
  }

  Future<MPerson> _getPerson(String id) async {
    final r = await Sql.get(Tables.person, whereValues: [
      SqlWhere(
        key: "id",
        value: id,
        operator: "=",
        logicalOperators: "",
      )
    ]);

    return MPerson.fromJson(r!.first);
  }

  Future<void> onPersonTap(int index) async {
    final r = await context.navigatorPush(NotePageView(
      person: persons[index],
    ));

    if (r != null && r is String) {
      persons.removeWhere((element) => element.id == r);
      notesReminder.removeWhere((element) => element.personId == r);

      setState(() {});
    }
  }

  Future<void> onFABTap() async {
    final result = await context.navigatorPush(const NewPersonPageView());

    if (result == null) return;

    if (result is MPerson) _addPerson(result);
  }

  void _addPerson(MPerson person) {
    setState(() {
      persons.add(person);
    });
  }

  Future<void> onNoteTap(int index) async {
    MNote n = notesReminder[index];

    final result = await Sql.get(
      Tables.person,
      whereValues: [
        SqlWhere(
          key: "id",
          value: n.personId,
          operator: "=",
          logicalOperators: "",
        )
      ],
    );

    if (result == null) return;

    MPerson p = MPerson.fromJson(result.first);

    final r = await context
        .navigatorPush<MNote?>(NewNotePageView(person: p, note: n));

    if (r == null) return;

    int i = notesReminder.indexWhere((element) => element.id == r.id);
    if (i == -1) return;
    setState(() {
      notesReminder[index] = r;
    });
  }
}
