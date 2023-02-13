import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mlkit_text_recognition_v2_app/utils/camera.dart';
import '../main.dart';

List<CameraDescription> cameras = [];

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraState();
}

class _CameraState extends State<CameraPage> {
  late CameraController _controller;
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.japanese);
  bool isReady = false;
  bool skipScanning = false;
  bool isScanned = false;
  RecognizedText? _recognizedText;
  Size? absoluteImageSize;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  _processImage(CameraImage availableImage) async {
    if (!mounted || skipScanning) return;
    setState(() {
      skipScanning = true;
    });

    final inputImage = convert(
      camera: cameras[0],
      cameraImage: availableImage,
    );

    _recognizedText = await _textRecognizer.processImage(inputImage);
    if (!mounted) return;
    setState(() {
      skipScanning = false;
      absoluteImageSize = inputImage.inputImageData?.size;
    });
    if (_recognizedText != null && _recognizedText!.text.isNotEmpty) {
      _controller.stopImageStream();
      setState(() {
        isScanned = true;
      });
    }
  }

  Future<void> _setup() async {
    cameras = await availableCameras();

    _controller = CameraController(cameras[0], ResolutionPreset.max);

    await _controller.initialize().catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });

    if (!mounted) {
      return;
    }

    setState(() {
      isReady = true;
    });

    _controller.startImageStream(_processImage);
  }

  String get newMethod => 'User denied camera access.';

  @override
  Widget build(BuildContext context) {
    final isLoading = !isReady || !_controller.value.isInitialized;

    if (isLoading) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('テキスト読み取り画面'),
          ),
          body: Column(
              children: const [Center(child: CircularProgressIndicator())]));
    }
    final Size imageSize = Size(
      _controller.value.previewSize!.width,
      _controller.value.previewSize!.height,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('テキスト読み取り画面'),
      ),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 6 / 9,
              child: Stack(
                children: [
                  ClipRect(
                    child: Transform.scale(
                      scale: _controller.value.aspectRatio * 6 / 9,
                      child: Center(
                        child: CameraPreview(_controller),
                      ),
                    ),
                  ),
                  Container(
                    height: imageSize.height,
                    width: imageSize.width,
                    decoration: ShapeDecoration(
                      shape: CustomShapeBorder(
                        blocks: _recognizedText?.blocks,
                        absoluteImageSize: absoluteImageSize,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        isScanned
            ? ElevatedButton(
                child: const Text('再度読み取る'),
                onPressed: () {
                  setState(() {
                    isScanned = false;
                    _recognizedText = null;
                  });
                  _controller.startImageStream(_processImage);
                },
              )
            : const Text('読み込み中'),
      ]),
    );
  }
}
