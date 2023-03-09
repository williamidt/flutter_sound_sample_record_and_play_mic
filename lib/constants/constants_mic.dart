
///
const int tSAMPLERATE = 8000;

/// Sample rate used for Streams
const int tSTREAMSAMPLERATE = 44000; // 44100 does not work for recorder on iOS

///
const int tBLOCKSIZE = 4096;

///
enum Media {
  ///
  file,

  ///
  buffer,

  ///
  asset,

  ///
  stream,

  ///
  remoteExampleFile,
}

///
enum AudioState {
  ///
  isPlaying,

  ///
  isPaused,

  ///
  isStopped,

  ///
  isRecording,

  ///
  isRecordingPaused,
}