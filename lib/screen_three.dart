import 'dart:convert';

import 'package:api_testing/Models/UserModel.dart';
import 'package:api_testing/screen_two.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ScreenThree extends StatefulWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  List<UserModel> userlist= [];
  Future<List<UserModel>> getUserApi ()async{
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data= jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;
    }
    else{
      return userlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3'),
      ),

      body: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenTwo()));
            },
            child: Container(
              height:50,
              width: 300,
              //width: double.infinity,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.teal,
              ),
              child: Center(child: Text('Screen Two')),

            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot ) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  else {
                    return ListView.builder(
                      itemCount: userlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReuseableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                                  ReuseableRow(title: 'Username', value: snapshot.data![index].username.toString()),
                                  ReuseableRow(title: 'email', value: snapshot.data![index].email.toString()),
                                  ReuseableRow(title: 'address', value: snapshot.data![index].address!.city.toString()),
                                  ReuseableRow(title: 'address', value: snapshot.data![index].address!.geo!.lat.toString()),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              )
          ),
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
