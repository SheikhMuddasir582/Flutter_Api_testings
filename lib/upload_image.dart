import 'dart:io';
import 'dart:convert';
import 'package:api_testing/signup.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker= ImagePicker();
  bool showSpinner= false;
  Future getImage() async{
    final pickedfile= await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if(pickedfile != null){
      image= File(pickedfile.path);
      setState(() {

      });
    }
    else{
      print('no image found');
    }
  }
  Future <void> uploadImage() async{
    setState(() {
      showSpinner= true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length= await image!.length();
    var uri= Uri.parse('https://fakestoreapi.com/products');
    var request= new http.MultipartRequest('POST', uri);
    request.fields['title']= "My title";
    var mutipart= new http.MultipartFile('image', stream, length);
    request.files.add(mutipart);
    var response= await request.send();
    print(response.stream.toString());
    if(response.statusCode == 200){
      setState(() {
        showSpinner= false;
      });
      print('image uploaded');
    }
    else{
      print('operation failed');
      setState(() {
        showSpinner= false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upload Image Api'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
              },
              child: Container(
                height:50,
                width: 300,
                //width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.teal,
                ),
                child: Center(child: Text('Screen Five')),

              ),
            ),
             SizedBox(height: 150,),
             GestureDetector(
               onTap: (){
                 getImage();
               },
               child: Container(
                 child: image == null ? Center(child: Text('select image'),)
                     :
                     Container(
                       child: Center(
                         child: Image.file(
                           File(image!.path).absolute,
                           height: 100,
                           width: 100,
                           fit: BoxFit.cover,
                         ),

                       ),
                     ),
               ),
             ),
            SizedBox(height: 150,),
            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.green,
                child: Center(child: Text('Upload Image'),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
