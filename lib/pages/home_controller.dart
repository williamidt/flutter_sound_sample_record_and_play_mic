import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

typedef _Fn = void Function();

class HomeController extends GetxController {
  /// variaveis obx
  final RxString _recordTime = '00:00:00'.obs;
  final RxString _playTime = '00:00:00'.obs;
  final RxBool _recording = false.obs;

  /// constants
  static const theSource = AudioSource.microphone;

  /// variaveis internas
  bool? _encoderSupported = true; // Optimist
  bool _decoderSupported = true; // Optimist
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  Codec _codec = Codec.mp3;
  String _mPath = 'record_file.mp3';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();

  ///=======================================================
  /// getter and setter

  String get recordTime => _recordTime.value;
  String get playTime => _playTime.value;
  bool get isRecording => _recording.value;

  set recordTime(value) => _recordTime.value = value;
  set playTime(value) => _playTime.value = value;
  set isRecording(value) => _recording.value = value;

  ///=======================================================
  /// on init
  @override
  void onInit() {
    super.onInit();
    _initializePlayerAndRecord();
  }

  @override
  void onClose(){
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.onClose();
  }

  ///=======================================================
  /// function , parameters and actions

  /// inicializa modulos
  Future<void> _initializePlayerAndRecord() async {
    _mPlayer!.openPlayer().then((value) {
        _mPlayerIsInited = true;
    });

    openTheRecorder().then((value) {
        _mRecorderIsInited = true;
    });
  }

  /// configurar o codec
  Future<void> setCodec(Codec codec) async {
    _encoderSupported = await _mRecorder!.isEncoderSupported(codec);
    _decoderSupported = await _mPlayer!.isDecoderSupported(codec);
  }

  /// enable microfone to recorder : here only init module
  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  /// ----------------------  Here is the code for recording and playback -------

  void record() {
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      /// vazio
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      _mplaybackReady = true;
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: _mPath,
            whenFinished: () {
              ///
            })
        .then((value) {});
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      /// vazio
    });
  }

  /// ----------------------------- UI --------------------------------------------
  getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    _mRecorder!.isStopped ? record : stopRecorder;
  }

  getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }
}
