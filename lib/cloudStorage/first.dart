import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class First1 extends StatefulWidget {
  First1({Key? key}) : super(key: key);

  @override
  _First1State createState() => _First1State();
}

class _First1State extends State<First1> {
  ///////////////////////////////

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
                  onPressed: () async {
                    await getNameOfImageInFirebase();
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

  ///////////////////////
  first1(context) async {
    File? file;
    var imagepicker = ImagePicker();
    var imgpick = await imagepicker.getImage(source: ImageSource.camera);
    if (imgpick != null) {
      file = File(imgpick.path);
      var nameimage = basename(imgpick.path);

      var ref = FirebaseStorage.instance.ref("images/$nameimage");
      await ref.putFile(file).then((value) {
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
  ////////////////////
  secondTestUseingChildInRefAndUseingRandomName(context) async {
    File? file;
    ImagePicker imagepicker = ImagePicker();

    var pickimage = await imagepicker.getImage(source: ImageSource.camera);
    ////
    if (pickimage != null) {
      file = File(pickimage.path);
      var imagename = basename(pickimage.path);
      ////
      var unicname = Random().nextInt(100000);
      String unicqImageNameRandom = "$unicname--$imagename";
      ////
      String datetime = DateTime.now().toString();
      String uniqImageNameDateTime = "$datetime--$imagename";
      ////
      var ref = FirebaseStorage.instance
          .ref("images")
          .child("child")
          .child(imagename);
      await ref.putFile(file).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("ADDED")));
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("ERROR")));
    }
  }

  ////////////////////
  getNameOfImageInFirebase() async {
    var ref = await FirebaseStorage.instance
        .ref("images/child")
        .list(ListOptions(maxResults: 100));

    ref.items.forEach((element) {
      print("++++++++++++++++++++++++");
      print(element.fullPath);
      print(element.name);
    });

    /*//get name of folder
    ref.prefixes.forEach((element) {
      print(element.name);
    });
     */
  }
}
