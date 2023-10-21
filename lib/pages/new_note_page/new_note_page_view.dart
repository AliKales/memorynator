import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';
import 'package:memorynator/core/local_utils.dart';
import 'package:memorynator/core/models/m_note.dart';
import 'package:memorynator/core/models/m_person.dart';
import 'package:memorynator/core/sql.dart';
import 'package:memorynator/pages/new_note_page/widgets/images_widget/images_widget.dart';
import 'package:memorynator/widgets/buttons/b_filled.dart';
import 'package:memorynator/widgets/c_date_picker/c_date_picker.dart';
import 'package:memorynator/widgets/c_text_field.dart';
import 'package:memorynator/widgets/picture_image.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/audio_widget/audio_widget.dart';

part 'mixin_new_note_page.dart';

class NewNotePageView extends StatefulWidget {
  const NewNotePageView({super.key, required this.person, this.note});

  final MPerson person;
  final MNote? note;

  @override
  State<NewNotePageView> createState() => _NewNotePageViewState();
}

class _NewNotePageViewState extends State<NewNotePageView>
    with _MixinNewNotePage {
  @override
  void initState() {
    super.initState();
    person = widget.person;
    initNote(widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: Values.paddingPage(context),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      context.sizedBox(height: Values.paddingHeightSmallXX),
                      CTextFormField(
                        labelText: "Title",
                        controller: tECTitle,
                        validator: textFieldValidator,
                      ),
                      context.sizedBox(height: Values.paddingHeightSmallXX),
                      CTextFormField(
                        labelText: "Note",
                        maxLines: null,
                        controller: tECNote,
                        validator: textFieldValidator,
                      ),
                      context.sizedBox(height: Values.paddingHeightSmall),
                      CDatePicker(
                        onDateChange: onReminderChange,
                        initValue: widget.note?.reminder,
                      ),
                      _divider(),
                      ImagesWidget(
                        onImagesChange: onImagePaths,
                        initValue: widget.note?.images,
                      ),
                      _divider(),
                      AudioWidget(
                        uid: widget.person.id,
                        onStateChange: audioWidgetState,
                        onRecordDone: onRecordDone,
                        initValue: widget.note?.audio,
                      ),
                      context.sizedBox(height: Values.paddingHeightSmall),
                    ],
                  ),
                ).expanded,
              ),
              context.sizedBox(height: Values.paddingHeightSmallXX),
              BFilled(
                text: isUpdate ? "UPDATE" : "ADD",
                onTap: onAdd,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Divider _divider() => const Divider(height: 50);

  AppBar _appBar() {
    return AppBar(
      title: Row(
        children: [
          PictureImage(
            size: kToolbarHeight * 0.8,
            randomAvatarText: widget.person.randomAvatarText,
            imagePath: widget.person.imagePath,
            name: widget.person.name,
          ),
          context.sizedBox(width: Values.paddingWidthSmallX),
          Text(widget.person.name ?? "-"),
        ],
      ),
      titleSpacing: -10,
      centerTitle: false,
      elevation: 0,
    );
  }
}
