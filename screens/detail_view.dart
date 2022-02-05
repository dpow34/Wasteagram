import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  const DetailView({ Key? key, required this.date, required this.image, 
  required this.quantity, required this.longitude, required this. latitude}) 
  : super(key: key);

  final date;
  final image;
  final quantity;
  final longitude;
  final latitude;

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wasteagram"),
        centerTitle: true,
      ),
      body: Column(children: [
        displayDate(), 
        displayImg(),
        displayQuantity(),
        displayLocation()]
      )
    );
  }

  displayDate() {
    return Padding(
      padding: EdgeInsets.only(top: datePadding(context)),
      child: Center(
        child: Text(widget.date,
        style: TextStyle(fontSize: dateFontSize(context))
        )
      )
    );
  }

  displayImg() {
    return Padding(
      padding: EdgeInsets.only(top: imgPadding(context)),
      child: SizedBox(
        width: imageSize("width"),
        height: imageSize("height"),
        child: Center(
          child: Image.network(widget.image)
        )
      )
    );
  }

  displayQuantity() {
    return Padding(
        padding: EdgeInsets.only(top: quantityPadding(context)),
        child: Center(
          child: Text("${widget.quantity} items",
          style: TextStyle(fontSize: quantityFontSize(context))
          )
        )
      );
    }
  
  displayLocation() {
    return Padding(
        padding: EdgeInsets.only(top: locationPadding(context)),
        child: Center(
          child: Text("Location (${widget.longitude}, ${widget.latitude})",
          style: TextStyle(fontSize: locationFontSize(context))
          )
        )
      );
    }

  imageSize(dimension){
    if (dimension == "width") {
      return MediaQuery.of(context).size.width;
    } else {
      return MediaQuery.of(context).size.width * 0.7;
    }
  }

  dateFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.08;
  }

  quantityFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.11;
  }

  locationFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.04;
  }

  datePadding(BuildContext context){
     return MediaQuery.of(context).size.width * 0.1;
  }

  imgPadding(BuildContext context){
     return MediaQuery.of(context).size.width * 0.18;
  }

  quantityPadding(BuildContext context){
     return MediaQuery.of(context).size.width * 0.25;
  }

  locationPadding(BuildContext context){
     return MediaQuery.of(context).size.width * 0.20;
  }
}