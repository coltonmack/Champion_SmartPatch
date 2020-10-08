import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// A screen that allows users to take a picture using a given camera.
class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SmartCapture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(children: <Widget>[
        Image.file(
          File(imagePath),
          width: 300,
          height: 300,
        ),
        FirebaseResults(imagePath: imagePath)
      ]),
    );
  }
}

class FirebaseResults extends StatefulWidget {
  final String imagePath;

  const FirebaseResults({Key key, this.imagePath}) : super(key: key);

  @override
  FirebaseResultsState createState() => FirebaseResultsState();
}

class FirebaseResultsState extends State<FirebaseResults> {
  bool isImageLoaded = false;
  bool readTextResults = false;

  @override
  void initState() {
    readImage();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        height: 100,
        child: isImageLoaded
            ? Container(
                child: readTextResults
                    ? Image.asset(
                        'assets/green_check.png',
                        width: 100,
                        height: 100,
                      )
                    : Image.asset(
                        'assets/red_x.png',
                        width: 100,
                        height: 100,
                      ))
            : SpinKitFadingCircle(color: Colors.black, size: 100));
  }

  Future readImage() async {
    FirebaseVisionImage smartImage =
        FirebaseVisionImage.fromFile(File(widget.imagePath));
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(smartImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          debugPrint(word.text);
          if (word.text.contains("C") || word.text.contains("c")) {
            setState(() {
              readTextResults = true;
            });
          }
        }
      }
    }
    setState(() {
      isImageLoaded = true;
    });
  }
}
