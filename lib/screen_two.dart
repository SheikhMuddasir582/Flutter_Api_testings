 import 'dart:convert';

import 'package:api_testing/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);
  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  
  List<Photos> photosList= [];
  Future<List<Photos>> getPhotos ()async
  {
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data= jsonDecode(response.body.toString());
    if(response.statusCode == 200)
      {
        for(Map i in data)
          {
            Photos photos= Photos(title: i['title'], url: i['url'], id: i['id']);
            photosList.add(photos);
          }
        return photosList;
      }
    else
      {
        return photosList;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Testing'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Container(
              height:50,
              width: 300,
              //width: double.infinity,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.teal,
              ),
              child: Center(child: Text('Screen 1')),

            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot)
            {
              return ListView.builder(
                itemCount: photosList.length,
                  itemBuilder: (context, index)
              {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  subtitle: Text(snapshot.data![index].title.toString()),
                  title: Text('Notes id:${snapshot.data![index].id}'),
                );
              });
            }),
          ),
        ],
      ),
    );
  }
}

class Photos
{
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
