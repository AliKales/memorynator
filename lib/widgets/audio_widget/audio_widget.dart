import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:caroby/caroby.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:memorynator/core/local_utils.dart';
import 'package:memorynator/core/local_values.dart';
import 'package:memorynator/widgets/title_switch.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'mixin_audio_widget.dart';
part 'widgets/icon_done.dart';

class AudioWidget extends StatefulWidget {
  const AudioWidget({
    super.key,
    required this.uid,
    this.onStateChange,
    this.onRecordDone,
    this.initValue,
  });

  final String uid;

  ///[onStateChange] will called if user turn it on or off.
  final ValueChanged<bool>? onStateChange;

  ///[onRecordDone] will return path to audio
  ///after audio record is completed.
  final ValueChanged<String?>? onRecordDone;

  final String? initValue;

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget>
    with _MixinAudioWidget, SingleTickerProviderStateMixin {
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    animationController = AnimationController(
      vsync: this,
      duration: 300.toDuration,
    );

    if (widget.initValue != null) {
      _switch = true;
      init();
      context.afterBuild((p0) => initPlayer(widget.initValue));
    }
  }

  void _onSwitch(bool val) {
    setState(() {
      _switch = val;
    });
    widget.onStateChange?.call(_switch);
    if (!_switch) {
      widget.onRecordDone?.call(null);
    }
  }

  Future<void> _stopRecording() async {
    final p = await stopRecord();
    widget.onRecordDone?.call(p);
  }

  bool get _isPlayerActive =>
      status == Status.playing || status == Status.resumed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSwitch(switchVal: _switch, onSwitch: _onSwitch, title: "Audio"),
        if (_switch)
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withOpacity(0.2),
              borderRadius:
                  BorderRadius.all(Radius.circular(Values.radiusLargeXX)),
            ),
            padding: EdgeInsets.all(
                Values.paddingWidthSmall.toDynamicWidth(context)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (_isPlayerActive)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ValueListenableBuilder(
                      valueListenable: durationAudio,
                      builder: (context, val, _) {
                        return ProgressBar(
                          progress: val,
                          total: maxDuration ?? val,
                          onSeek: seek,
                          thumbRadius: 8,
                        );
                      },
                    ),
                  ).expanded,
                if (status != Status.none && !_isPlayerActive)
                  ValueListenableBuilder(
                    valueListenable: timerRecord,
                    builder: (context, val, _) {
                      final t = Utils.formatVideoDuration(val);
                      return Text(t).expanded;
                    },
                  ),
                if (status == Status.none)
                  IconButton.filled(
                    onPressed: startRecord,
                    icon: const Icon(Icons.mic),
                  ).centerRow.expanded,
                if (status == Status.recording)
                  _IconDone(
                    onTap: _stopRecording,
                  ),
                if (_isPlayerActive)
                  IconButton.outlined(
                    onPressed: handleAudio,
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: animationController,
                    ),
                  ),
              ],
            ),
          ).animate().fade()
      ],
    );
  }
}
