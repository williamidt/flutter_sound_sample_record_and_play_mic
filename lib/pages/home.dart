import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_sample_record_and_play_mic/widgets/iconButton.dart';
import 'package:flutter_sound_sample_record_and_play_mic/controller/sound_controller.dart';

class HomePage extends StatelessWidget {
  /// constructor
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// controller getx
    SoundController mySoundController= Get.put(SoundController());

    /// tela
    return Scaffold(
        appBar: AppBar(
            title: Container(
                alignment: AlignmentDirectional.center,
                child: const Text("Flutter Record and Play"))),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 30),
          const Text("00:00:00", style: TextStyle(fontSize: 50)),
          const SizedBox(height: 30),
          const Text("Record audio", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          MyIconButton(
                  icon: mySoundController.isRecording
                      ? Icons.stop : Icons.mic,
                  onTap: () async {
                    await mySoundController.startstopRecorder();
                  },
                  color: mySoundController.isRecording ?
                      Colors.green : Colors.black
          ),
          const SizedBox(height: 30),
          const Text("Play audio", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyIconButton(
                  icon: Icons.play_arrow_sharp,
                  onTap: () => mySoundController.startPlaying(),
                  color: Colors.black),
              MyIconButton(
                  icon: Icons.pause,
                  onTap: () => mySoundController.pausePlayer(),
                  color: Colors.black),
              MyIconButton(
                  icon: Icons.stop,
                  onTap:  () => mySoundController.stopPlayer(),
                  color: Colors.black),
            ],
          )


        ]));
  }
}
