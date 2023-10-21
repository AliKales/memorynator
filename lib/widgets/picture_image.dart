import 'dart:io';

import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

class PictureImage extends StatelessWidget {
  const PictureImage({
    super.key,
    required this.size,
    required this.randomAvatarText,
    this.name,
    this.imagePath,
  });

  final double size;
  final String? randomAvatarText;
  final String? name;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: File(imagePath ?? "").exists(),
      builder: (context, snapshot) {
        if (snapshot.data.isTrue) {
          return _Image(size: size, imagePath: imagePath);
        }
        if (randomAvatarText == null) {
          return _Text(size: size, name: name);
        }
        return RandomAvatar(randomAvatarText!, width: size);
      },
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    required this.size,
    required this.name,
  });

  final double size;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.colorScheme.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            name?.substring(0, 1).toUpperCase() ?? "-",
            style: context.textTheme.displayMedium!.toBold,
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.size,
    required this.imagePath,
  });

  final double size;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(
            File(imagePath!),
          ),
        ),
      ),
    );
  }
}
