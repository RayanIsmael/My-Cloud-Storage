import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  PickImage({Key? key}) : super(key: key);

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  ///////////////////////////////
  File? image;

  var imagepicker = ImagePicker();

  pickimage() async {
    var imgpick = await imagepicker.getImage(source: ImageSource.gallery);
    if (imgpick != null) {
      setState(() {
        image = File(imgpick.path);
      });
    } else {
      print("Error");
    }
  }

  /////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image_Pick"),
        centerTitle: true,
      ),
      /////////////////
      body: Center(
        child: Column(
          children: [
            IconButton(
              onPressed: pickimage,
              icon: Icon(Icons.camera_alt_rounded),
            ),

            image ==null ?Text("No Picker") : Image.file(image!),
          ],
        ),
      ),
      /////////////////
    );
  }
}
