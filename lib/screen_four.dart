import 'dart:convert';

import 'package:api_testing/screen_three.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ScreenFour extends StatefulWidget {
  const ScreenFour({Key? key}) : super(key: key);

  @override
  State<ScreenFour> createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  var data;
  Future<void> getUserApi ()async{
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200){
      data= jsonDecode(response.body.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen four'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenThree()));
            },
            child: Container(
              height:50,
              width: 300,
              //width: double.infinity,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.teal,
              ),
              child: Center(child: Text('Screen Three')),

            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: getUserApi(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Text('loading');
              }
              else{
                return ListView.builder(
                  itemCount: data.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: Column(
                          children: [
                            ReuseableRow(title: 'Name', value: data[index]['name'].toString()),
                            ReuseableRow(title: 'Username', value: data[index]['username'].toString()),
                            ReuseableRow(title: 'email', value: data[index]['email'].toString()),
                            ReuseableRow(title: 'address', value: data[index]['address']['street'].toString()),
                            ReuseableRow(title: 'geo', value: data[index]['address']['geo']['lat'].toString()),
                          ],
                        ),
                      );
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}


class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],

    );
  }
}