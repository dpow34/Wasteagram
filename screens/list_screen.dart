import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'new_post.dart';
import 'detail_view.dart';


class ListScreen extends StatefulWidget {
  const ListScreen({ Key? key }) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}


class _ListScreenState extends State<ListScreen> {
  num count = 0;
  late File image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewPost(image: image))
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wasteagram"),
        centerTitle: true,
      ),
      body: listScreenBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(
        child:FloatingActionButton(
          tooltip: 'Add Post',
          child: Icon(Icons.camera_alt_rounded),
          onPressed:() {
            getImage();
          } 
        ),
        label: "Camera button",
        button: true,
        enabled: true,
        onTapHint: 'Select an Image'
      )
    );
  }



  Widget listScreenBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder:(context, snapshot) {
        if(snapshot.hasData && snapshot.data!.docs.length > 0){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var post = snapshot.data!.docs[index];
                return Semantics(
                  child: ListTile(
                    title: Text(post['date'].toString()),
                    trailing: Text(post['quantity'].toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => 
                          DetailView(
                            date: post['date'].toString(),
                            image: post['imageURL'],
                            quantity: post['quantity'],
                            latitude: post['latitude'],
                            longitude: post['longitude']
                          )
                        )
                      );
                    }
                  ),
                  label: "Specific entry",
                  enabled: true,
                  onTapHint: 'View Entry Details',
                );
              }
            );
        } else {
            return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}