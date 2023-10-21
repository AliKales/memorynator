// ignore_for_file: use_build_context_synchronously

part of 'audio_widget.dart';

enum Status { none, recording, resumed, playing }

mixin _MixinAudioWidget<T extends StatefulWidget> on State<T> {
  late String uid;
  late AnimationController animationController;

  late Status status;

  AudioRecorder record = AudioRecorder();
  AudioPlayer player = AudioPlayer();

  String? audioPath;

  Timer? _timerRecord;

  late ValueNotifier<Duration> durationAudio;

  Duration? maxDuration;

  late ValueNotifier<int> timerRecord;

  Future<void> initPlayer(String? p) async {
    audioPath = p;
    await setSource();
  }

  void init() {
    status = Status.none;

    durationAudio = ValueNotifier(0.toDuration);
    timerRecord = ValueNotifier(0);

    maxDuration = null;
    _timerRecord = null;
    audioPath = null;

    player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        status = Status.playing;
        animationController.forward();
      } else {
        status = Status.resumed;
        animationController.reverse();
      }
    });
    player.onPositionChanged.listen((event) {
      durationAudio.value = event;
    });

    player.onDurationChanged.listen((event) {
      maxDuration = event;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    disposes();
    super.dispose();
  }

  void disposes() {
    record.dispose();
    player.dispose();

    _timerRecord?.cancel();
  }

  Future<void> startRecord() async {
    if (!await record.hasPermission()) {
      CustomSnackbar.showSuccessSnackBar(context,
          text: "No permission granted!", isSuccess: false);
      return;
    }

    final id = LocalUtils.generateRandomId();

    final doc = await getApplicationCacheDirectory();

    final path = LocalValues.pathToAudios(
        deviceDocPath: doc.path, id: uid, fileName: "$id.m4a");

    await LocalUtils.createDirectory(path);

    await record.start(const RecordConfig(), path: path);

    _timerRecord = Timer.periodic(1000.toDuration, (timer) {
      timerRecord.value++;
    });

    _changeStatus(Status.recording);
  }

  Future<String?> stopRecord() async {
    _timerRecord?.cancel();
    audioPath = await record.stop();
    await setSource();
    return audioPath;
  }

  Future<void> setSource() async {
    await player.setSourceDeviceFile(audioPath!);
    await player.setReleaseMode(ReleaseMode.stop);
    _changeStatus(Status.resumed);
  }

  Future<void> seek(Duration d) async {
    await player.seek(d);
  }

  void handleAudio() {
    status == Status.playing ? _stopAudio() : _startAudio();
  }

  Future<void> _startAudio() async {
    await player.resume();
  }

  Future<void> _stopAudio() async {
    await player.pause();
  }

  void _changeStatus(Status s) {
    setState(() {
      status = s;
    });
  }
}
