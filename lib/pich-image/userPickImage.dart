import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_cloudstorage/pich-image/getimage.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  PickImage({Key? key}) : super(key: key);

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  ///////////////////////////////
  List<File> image = [];
  CollectionReference? image_url;

  var imagepicker = ImagePicker();

  bool upload = false;
  double prognumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image_Pick"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () async {
                setState(() {
                  upload = true;
                });
                await addingToStorage()
                    .whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Display(),)));
              },
              child: Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      /////////////////
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: image.length + 1,
            itemBuilder: (context, index) {
              return index == 0
                  ? IconButton(
                      onPressed: () async{
                        // ignore: unnecessary_statements
                        !upload ? await pickimage() : null;
                      },
                      icon: Icon(Icons.add_a_photo_rounded))
                  : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(
                                image[index - 1],
                              ),
                              fit: BoxFit.fill)),
                    );
            },
          ),
          upload
              ? Center(
                  child: CircularProgressIndicator(
                    value: prognumber,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                )
              : Container(),
        ],
      ),
      /////////////////
    );
  }

  ////////////////
  pickimage() async {
    var imgpick = await imagepicker.getImage(source: ImageSource.gallery);
    if (imgpick != null) {
      setState(() {
        image.add(File(imgpick.path));
      });
    } else {
      print("Error");
    }
  }

  /////////////////
  Future addingToStorage() async {
    int i = 1;
    if (image.isEmpty) {
      print("image.isEmpty");
    } else {
      for (var img in image) {
        setState(() {
          prognumber = i / image.length;
        });
        var imagename = basename(img.path);
        var ref = FirebaseStorage.instance
            .ref("images")
            .child("child")
            .child(imagename);
        await ref.putFile(img).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            image_url!.add({"url": value});
            i++;
          });
        });
      }
    }
  }

  /////////
  @override
  void initState() {
    image_url = FirebaseFirestore.instance.collection("urlImage");

    super.initState();
  }
}
