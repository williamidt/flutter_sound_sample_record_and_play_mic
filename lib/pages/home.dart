import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_sample_record_and_play_mic/pages/home_controller.dart';
import 'package:flutter_sound_sample_record_and_play_mic/widgets/iconButton.dart';


class HomePage extends StatelessWidget {
  /// controller getx
  final HomeController myHomeController = Get.find();

  /// constructor
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Container(
                alignment: AlignmentDirectional.center,
                child: const Text("Flutter Record and Play"))),
        body: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text("time record", style: TextStyle(fontSize: 28)),
              SizedBox(height: 30),
              MyIconButton(
                  icon: Icons.mic,
                  onTap: null,
                  buttonSize: 4,
                  color: Colors.black),
              SizedBox(height: 30),
              Text("time play", style: TextStyle(fontSize: 28)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyIconButton(
                      icon: Icons.play_arrow,
                      onTap: null,
                      buttonSize: 4,
                      color: Colors.black),
                  MyIconButton(
                      icon: Icons.pause,
                      onTap: null,
                      buttonSize: 4,
                      color: Colors.black),
                  MyIconButton(
                      icon: Icons.stop,
                      onTap: null,
                      buttonSize: 4,
                      color: Colors.black),
                ],
              )
            ]));
  }
}
