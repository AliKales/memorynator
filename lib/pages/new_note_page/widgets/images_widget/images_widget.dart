import 'dart:io';

import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memorynator/widgets/title_switch.dart';

part 'image.dart';

class ImagesWidget extends StatefulWidget {
  const ImagesWidget({
    super.key,
    required this.onImagesChange,
    this.initValue,
  });

  final ValueChanged<List<String>?> onImagesChange;
  final List<String>? initValue;

  @override
  State<ImagesWidget> createState() => _ImagesWidgetState();
}

class _ImagesWidgetState extends State<ImagesWidget> {
  List<String> _imagePaths = [];

  bool _switch = false;

  @override
  void initState() {
    super.initState();
    if (widget.initValue != null) {
      _switch = true;
      _imagePaths = widget.initValue!;
    }
  }

  void _changeSwitch(bool val) {
    if (_switch) {
      _imagePaths = [];
      widget.onImagesChange.call(null);
    }
    setState(() {
      _switch = val;
    });
  }

  Future<void> _addImage() async {
    List<XFile> xFiles = await ImagePicker().pickMultiImage();
    if (xFiles.isEmpty) return;

    _imagePaths += xFiles.map((e) => e.path).toList();

    widget.onImagesChange.call(_imagePaths);

    setState(() {});
  }

  void _deleteImage(int index) {
    setState(() {
      _imagePaths.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSwitch(
            switchVal: _switch, onSwitch: _changeSwitch, title: "Images"),
        if (_switch)
          Container(
            width: double.maxFinite,
            height: 0.25.toDynamicHeight(context),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Values.radiusMedium)),
              border: Border.all(
                color: context.colorScheme.primary.withOpacity(0.3),
              ),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                  _imagePaths.length,
                  (index) => _Image(
                    imagePath: _imagePaths[index],
                    onDelete: () => _deleteImage(index),
                  ),
                ),
                InkWellNoGlow(
                  onTap: _addImage,
                  child: const _Image(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
