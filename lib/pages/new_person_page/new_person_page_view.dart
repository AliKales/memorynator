import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memorynator/core/local_utils.dart';
import 'package:memorynator/core/models/m_person.dart';
import 'package:memorynator/core/sql.dart';
import 'package:memorynator/widgets/buttons/b_filled.dart';
import 'package:memorynator/widgets/c_text_field.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/local_values.dart';
import '../../widgets/picture_image.dart';

part 'mixin_new_person_page.dart';
part 'widgets/pic.dart';

class NewPersonPageView extends StatefulWidget {
  const NewPersonPageView({super.key});

  @override
  State<NewPersonPageView> createState() => _NewPersonPageViewState();
}

class _NewPersonPageViewState extends State<NewPersonPageView>
    with _MixinNewPersonPage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("New Person"),
        elevation: 0,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: Values.paddingPage(context),
      child: Column(
        children: [
          context.sizedBox(height: Values.paddingHeightSmallXX),
          _Pic(
            randomAvatar: picNick,
            onPicChange: onPicChange,
            onSubmit: onPicNickSubmit,
            onFromGallery: onFromGallery,
            imagePath: selectedImage?.path,
          ),
          const Divider(),
          CTextField(labelText: "Name", onChanged: onNameChange),
          context.sizedBox(height: Values.paddingHeightSmallXX),
          CTextField(
            controller: tECCreatedAt,
            labelText: "Created At",
            readOnly: true,
            suffixIcon: const Icon(Icons.date_range_outlined),
          ),
          const Spacer(),
          BFilled(text: "SAVE", onTap: onSave),
          context.sizedBox(height: Values.paddingHeightSmallX),
        ],
      ),
    );
  }
}
