// ignore_for_file: use_build_context_synchronously

part of 'new_note_page_view.dart';

mixin _MixinNewNotePage<T extends StatefulWidget> on State<T> {
  late MPerson person;

  final TextEditingController tECTitle = TextEditingController();
  final TextEditingController tECNote = TextEditingController();

  final formKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();

  late MNote note;

  bool isUpdate = false;

  void initNote(MNote? n) {
    if (n != null) {
      isUpdate = true;
      tECTitle.text = n.title ?? "";
      tECNote.text = n.note ?? "";
    }

    note = n ??
        MNote(
          id: LocalUtils.generateRandomId(),
          personId: person.id,
          createdAt: DateTime.now(),
        );
  }

  @override
  void dispose() {
    tECNote.dispose();
    tECTitle.dispose();
    scrollController.dispose();
    super.dispose();
  }

  String? textFieldValidator(String? value) {
    if (value.isEmptyOrNull) {
      return "Please fill here up!";
    }
    return null;
  }

  Future<void> onAdd() async {
    if (!formKey.currentState!.validate()) return;

    note.title = tECTitle.textTrim;
    note.note = tECNote.textTrim;

    SqlResult result;

    final cache = await getApplicationCacheDirectory();

    if (note.audio.isNotEmptyAndNull && note.audio!.contains(cache.path)) {
      final doc = await getApplicationDocumentsDirectory();
      String from = note.audio!;
      String to = from.replaceAll(cache.path, doc.path);
      await LocalUtils.changeFileLocation(from: from, to: to);

      note.audio = to;
    }

    if (isUpdate) {
      result = await Sql.update(
        note.toJson(),
        Tables.note,
        [
          SqlWhere(
            key: "id",
            value: note.id,
            operator: "=",
            logicalOperators: "AND",
          )
        ],
      );
    } else {
      result = await Sql.add(note.toJson(), Tables.note);
    }

    if (result == SqlResult.error) {
      CustomSnackbar.showSuccessSnackBar(
        context,
        text: "Error!",
        isSuccess: false,
      );
      return;
    }

    Navigator.pop(context, note);
  }

  Future<void> audioWidgetState(bool val) async {
    if (!val) return;
    await Future.delayed(300.toDuration);
    scrollController.animateTo(
      scrollController.max,
      duration: 100.toDuration,
      curve: Curves.ease,
    );
  }

  void onRecordDone(String? p) => note.audio = p;

  void onImagePaths(List<String>? i) => note.images = i;

  void onReminderChange(DateTime? d) => note.reminder = d;
}
