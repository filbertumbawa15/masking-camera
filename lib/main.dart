import 'dart:typed_data';

import 'package:camera_project/widgets/mask_for_camera_view.dart';
import 'package:camera_project/widgets/mask_for_camera_view_camera_description.dart';
import 'package:camera_project/widgets/mask_for_camera_view_result.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaskForCameraView(
      visiblePopButton: false,
      boxBorderWidth: 3.0,
      cameraDescription: MaskForCameraViewCameraDescription.rear,
      onTake: (MaskForCameraViewResult res) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26.0),
              topRight: Radius.circular(26.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Cropped Images",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12.0),
              res.croppedImage != null
                  ? MyImageView(imageBytes: res.croppedImage!)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyImageView extends StatelessWidget {
  const MyImageView({Key? key, required this.imageBytes}) : super(key: key);
  final Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: SizedBox(
        width: double.infinity,
        child: Image.memory(imageBytes),
      ),
    );
  }
}
