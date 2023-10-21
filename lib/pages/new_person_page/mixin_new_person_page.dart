// ignore_for_file: use_build_context_synchronously

part of 'new_person_page_view.dart';

mixin _MixinNewPersonPage<T extends StatefulWidget> on State<T> {
  late TextEditingController tECCreatedAt;
  final DateTime _timeNow = DateTime.now();

  String _name = "";
  String? picNick;
  XFile? selectedImage;

  @override
  void initState() {
    super.initState();
    tECCreatedAt = TextEditingController(text: _timeNow.toStringFromDate);
  }

  @override
  void dispose() {
    tECCreatedAt.dispose();
    super.dispose();
  }

  void onNameChange(String value) => _name = value;
  void onPicChange(String value) => picNick = value;

  void onPicNickSubmit() {
    setState(() {});
  }

  Future<void> onFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      selectedImage = image;
    });
  }

  Future<void> onSave() async {
    if (_checkName()) return;

    final id = LocalUtils.generateRandomId();

    final newPath = await _handleSelectedImage(id);

    MPerson person = MPerson(
      id: id,
      name: _name.trim(),
      createdAt: _timeNow,
      imagePath: newPath,
      randomAvatarText: picNick,
    );

    final result = await Sql.add(person.toJson(), Tables.person);

    if (result == SqlResult.error) {
      CustomSnackbar.showSuccessSnackBar(
        context,
        text: "Error!",
        isSuccess: false,
      );
      return;
    }

    Navigator.pop(context, person);
  }

  Future<String?> _handleSelectedImage(String id) async {
    if (selectedImage == null) return null;
    final docPath = await getApplicationDocumentsDirectory();
    final newPath = LocalValues.pathToImages(
      deviceDocPath: docPath.path,
      id: id,
      fileName: selectedImage!.name,
    );

    await LocalUtils.changeFileLocation(from: selectedImage!.path, to: newPath);

    return newPath;
  }

  bool _checkName() {
    if (_name.trim().isEmpty) {
      CustomSnackbar.showSuccessSnackBar(context,
          text: "Name can't be empty!", isSuccess: false);
      return true;
    }

    return false;
  }
}
