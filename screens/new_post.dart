import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:location/location.dart';
import 'list_screen.dart';
import '../models/formatted_date.dart';


class NewPost extends StatefulWidget {
  const NewPost({ Key? key, required this.image}) : super(key: key);
  final File image;

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final formKey = GlobalKey<FormState>();
  var url;
  var date;
  bool check = false;
  late LocationData locationData;
  TextEditingController quantity = new TextEditingController();

  getimage() async{
    Reference storageReference = 
      FirebaseStorage.instance.ref().child(Path.basename(widget.image.path));
    await storageReference.putFile(widget.image);
    url = await storageReference.getDownloadURL();
    check = true;
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async{
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }

  Widget build(BuildContext context) {
    if (check == false) {
      getimage();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: display()
    );
  }

    Widget display() {
      if (url == null) {
        return Center(child: CircularProgressIndicator());
      } else {
      return Column(
        children: [
          img(),
          Semantics(
            child: inputBox(),
            label: 'Input field for wasted items',
            onTapHint: 'Enter the amount of wasted items',
            textField: true,
          ),
          Semantics(
            child: uploadButton(),
            label: 'Upload button',
            onTapHint: 'Push to upload entry',
            button: true,
            enabled: true
          )
        ]
      );
      }
    }

    img() {
      return SizedBox(
        child: Image.network(url),
        height: imageSize("height"),
        width: imageSize("width")
      );
    }

    inputBox() {
      return Padding(
        padding: EdgeInsets.only(
          left:padding(context), 
          right: padding(context),
          top: padding(context)*4
        ),
        child: SizedBox(
          height: inputSize("height"),
          width: inputSize("width"),
          child: Form(
            key: formKey, 
            child: TextFormField(
              controller: quantity,
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Number of Wasted Items',
                hintStyle: TextStyle(fontSize: 30)
              ),
              validator: (value) {
                if(value!.isEmpty) {
                  return 'Please enter a number';
                }
              }
            )
          )
        )
      );
    }


    uploadButton() {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(
              left: buttonSidePadding(context), 
              right: buttonSidePadding(context), 
              top: buttonVerticalPadding(context), 
              bottom: buttonVerticalPadding(context)
            )
          ),
          onPressed: () {
            formKey.currentState!.validate();
            FirebaseFirestore.instance.collection('posts').add({
              'date': FormattedDate().formatDate(),
              'imageURL': url,
              'quantity': quantity.text,
              'latitude': locationData.latitude,
              'longitude': locationData.longitude
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListScreen())
            );
          }, 
          child: Center(
            child: Icon(
              Icons.cloud_upload, 
              size: iconSize(context)
            )
          )
      );
    }

    imageSize(dimension){
      if (dimension == "width") {
        return MediaQuery.of(context).size.width;
      } else {
        return MediaQuery.of(context).size.width * 0.56;
      }
    }

    inputSize(dimension){
      if (dimension == "width") {
        return MediaQuery.of(context).size.width;
      } else {
        return MediaQuery.of(context).size.width * 0.747;
      }
    }

    double iconSize(BuildContext context) {
      return MediaQuery.of(context).size.width * 0.19;
    }

    double buttonSidePadding(BuildContext context) {
      return MediaQuery.of(context).size.width * 0.05;
    }

   double buttonVerticalPadding(BuildContext context) {
      return MediaQuery.of(context).size.width * 0.0159;
    }

    double uploadPadding(BuildContext context) {
      return MediaQuery.of(context).size.longestSide * 0.35;
    }

    double padding(BuildContext context) {
      return MediaQuery.of(context).size.width * 0.05;
    }

}