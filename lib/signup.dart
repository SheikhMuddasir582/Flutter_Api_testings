import 'dart:convert';

import 'package:api_testing/screen_five.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' ;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailControl= TextEditingController();
  TextEditingController passwordControl= TextEditingController();
  void login(String email, password) async{
    try{
      Response response= await post(
        Uri.parse('https://reqres.in/api/register'),
         // Uri.parse('https://reqres.in/api/login'),
       body:{
         'email' : email,
         'password' : password,
       }
      );
      if(response.statusCode == 200){
        var data= jsonDecode(response.body.toString());
        //print(data);
        print(data['id']);
        print('Account Created successfully');
      }
      else{
        print('failed try again');
      }
    }
    catch(e){
     print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenFive()));
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
            TextFormField(
              controller: emailControl,
              decoration: InputDecoration(hintText: 'email'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordControl,
              decoration: InputDecoration(hintText: 'password'),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){
                login(emailControl.text.toString(), passwordControl.text.toString());
              },
              child: Container(
                height: 50,

                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text('Sign Up'),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
