import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  Display({Key? key}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Display Image"),
          centerTitle: true,
        ),
        /////////////////
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("urlImage").snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: FadeInImage.assetNetwork(
                          placeholder: 'images/12.png',
                          image: snapshot.data!.docs[index].get("url"),
                          fit: BoxFit.fill,
                        ));
                      },
                    ),
                  );
          },
        )
        /////////////////
        );
  }
}
