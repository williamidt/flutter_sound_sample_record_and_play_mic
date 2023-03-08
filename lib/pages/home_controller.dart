import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  /// variaveis obx
   final RxString _recordTime = '00:00:00'.obs;
   final RxString _playTime = '00:00:00'.obs;
   final RxBool _recording = false.obs;

   /// variaveis internas
   bool? _encoderSupported = true; // Optimist
   bool _decoderSupported = true; // Optimist
   bool _mPlayerIsInited = false;
   bool _mRecorderIsInited = false;
   bool _mplaybackReady = false;
   Codec _codec = Codec.mp3;
   String _mPath = 'record_file.mp3';
   FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
   FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();

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
 /*  @override
   void onInit() {
      super.onInit();
   }*/

   ///=======================================================
   /// function , parameters and actions

   /// inicializa modulos
   Future<void> _initializeExample() async {
      await _mPlayer.closePlayer();
      await _mPlayer.openPlayer();
      await _mPlayer.setSubscriptionDuration(Duration(milliseconds: 10));
      await _mRecorder.setSubscriptionDuration(Duration(milliseconds: 10));
//      await initializeDateFormatting();
      await setCodec(_codec);
   }


   /// configurar o codec
   Future<void> setCodec(Codec codec) async {
      _encoderSupported = await _mRecorder.isEncoderSupported(codec);
      _decoderSupported = await _mPlayer.isDecoderSupported(codec);
   }
/*

/// start record
   startRecording(){
      String path = _flutterSound.s flutterSound.startPlayer(null);
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
         if (e != null) {
            DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
            String txt = DateFormat(‘mm:ss:SS’, ‘en_US’).format(date);
            this.setState(() {
               this._isPlaying = true;
               this._playerTxt = txt.substring(0, 8);
            });
         }
      });
   }

*/


}