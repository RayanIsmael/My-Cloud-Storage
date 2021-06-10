import 'package:flutter/material.dart';
import 'package:my_cloudstorage/cloudStorage/first.dart';
import 'package:my_cloudstorage/pich-image/userPickImage.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      /////////////////
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///////////
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text("Only Image_picker Page"),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PickImage(),
                    ));
                  },
                  icon: Icon(Icons.add),
                ),
                
              ],
            ),
            //////////
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("First FirebaseStorage"),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => First1(),
                    ));
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            //////////
          ],
        ),
      ),
      /////////////////
    );
  }
}
