import 'dart:async';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;


class SoundController extends GetxController {

  /// variaveis obx
  RxBool _isrecording = false.obs;
  RxBool _isplaying = false.obs;
  RxString _subscription = "00:00:00".obs;

  /// flutter sound variavel
  FlutterSoundRecorder? _audioRecorder;
  Directory? _diretorio;
  final String _file = 'audio_example.aac';
  final _audioPlayer = AssetsAudioPlayer();
  bool _isRecorderInitialized = false;

  ///==========================================================================
  /// getter and setter

  bool get isRecording => _audioRecorder!.isRecording;
  String get subscription => _subscription.value.toString();

  ///==========================================================================
  @override
  void onInit() {
    _initRecorder();
    super.onInit();
  }

  @override
  void onClose() {
    _finishRecorder();
    super.onClose();
  }

  /// function to init
  Future _initRecorder() async {
    _audioRecorder = FlutterSoundRecorder();

    /// permission check
    PermissionStatus statusmic = await Permission.microphone.request();
    if (statusmic != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission failed");
    }
    PermissionStatus statusstorage = await Permission.storage.request();
    if (statusstorage != PermissionStatus.granted) {
      throw RecordingPermissionException("Storage permission failed");
    }
    PermissionStatus statusmanageexternal = await Permission.manageExternalStorage.request();
    if (statusmanageexternal != PermissionStatus.granted) {
      throw RecordingPermissionException("Manage External Storage permission failed");
    }

    await _audioRecorder!.openRecorder();
    await _audioRecorder!.setSubscriptionDuration(Duration(microseconds: 10));
    await initializeDateFormatting("en_US", "");
    _isRecorderInitialized = true;
  }

  /// dispose Recorder
  void _finishRecorder() {
    if (!_isRecorderInitialized) return;

    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    _isRecorderInitialized = false;
  }

  /// function to start
  Future _startRecorder() async {
    if (!_isRecorderInitialized) return;

    /// take directory
    _diretorio = Directory(path.dirname(_file));
    if (!_diretorio!.existsSync()){
      _diretorio!.createSync();
    }

    /// set status getx controller
    _isrecording.value = true;
    update();

    ///  starting recording
    await _audioRecorder!.startRecorder(toFile: _file);

    /// get recording subscription
    StreamSubscription _recordSubscription = _audioRecorder!.onProgress!.listen((e) {
      var date = DateTime.fromMicrosecondsSinceEpoch(e.duration.inMicroseconds, isUtc: true);
      var txt = DateFormat("mm:ss:SS", "en_US").format(date);
      _subscription.value = txt.substring(0,8);
    });
    _recordSubscription.cancel();
  }

  /// stop recorder
  Future _stopRecorder() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.stopRecorder();
    _isrecording.value = false;
    update();
  }

  /// start stop recorder
  Future startstopRecorder() async {
    if (_audioRecorder!.isStopped) {
      await _startRecorder();
    } else {
      await _stopRecorder();
    }
  }

  /// start player
  Future<void> startPlaying() async {
    _audioPlayer.open(
      Audio.file(_file),
      autoStart: true,
      showNotification: true
    );
  }

  /// stop player
  Future<void> stopPlayer() async {
    _audioPlayer.stop();
  }

  /// pause player
  Future<void> pausePlayer() async {
    _audioPlayer.pause();
  }


}
