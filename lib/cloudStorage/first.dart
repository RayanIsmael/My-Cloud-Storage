import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class First1 extends StatefulWidget {
  First1({Key? key}) : super(key: key);

  @override
  _First1State createState() => _First1State();
}

class _First1State extends State<First1> {
  ///////////////////////////////
  File? file;

  var imagepicker = ImagePicker();

  First1(context) async {
    var imgpick = await imagepicker.getImage(source: ImageSource.camera);
    if (imgpick != null) {
      file = File(imgpick.path);
      var nameimage = basename(imgpick.path);

      var ref = FirebaseStorage.instance.ref("images/$nameimage");
      await ref.putFile(file!).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Added")));
      });
      var url = ref.getDownloadURL();
      print(url);
    } else {
      print("Error");
    }
    print("Loding ...");
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ////////
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Image_Picker"),
                IconButton(
                  onPressed: () async{
                    await First1(context);
                  },
                  icon: Icon(Icons.camera_alt_rounded),
                ),
              ],
            ),
            ////////
          ],
        ),
      ),
      /////////////////
    );
  }
  ////////////////////
  
  ////////////////////
}
