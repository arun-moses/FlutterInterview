import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterinterviewtest/API.dart';
import 'package:flutterinterviewtest/user.dart';
import 'dart:async';
import 'package:http/http.dart' as http;


void main() => runApp(new MaterialApp(home: new Scaffold(body: new MyAppList())));
var usersList;
var categorylist = new List<Post>();
int _n = 0;

/*class MyAppList extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Http App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyListScreen(),
    );
  }
}*/

class MyAppList extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyAppList> {
  var users = new List<User>();
  var users1 = new List<Post>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }



  initState() {
    super.initState();
    //_getUsers();
    _fetchJobs();
    print(users1.length);
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(context) {
    return FutureBuilder<List<Post>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post> data = snapshot.data;
          return _jobsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

}
ListView _jobsListView(data) {

  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Material(
         child: Card(
           elevation: 8.0,
           margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
           child: Container(
             decoration: BoxDecoration(color: Colors.white),
             child: Container(
               padding: EdgeInsets.all(15),
               height: 220,
               child: Stack(
                 children: [
                   Column(
                     children: [
                       Align(
                         alignment: Alignment.topLeft,
                         child: Text(data[index].dish_name,
                             style: TextStyle(
                               fontWeight: FontWeight.w500,
                               fontSize: 20,
                             )),
                       ),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text("INR "+data[index].dish_price,
                               style: TextStyle(
                                 fontWeight: FontWeight.w500,
                                 fontSize: 20,
                               )),
                           Text(data[index].dish_calories,
                               style: TextStyle(
                                 fontWeight: FontWeight.w500,
                                 fontSize: 20,
                               )),
                           Align(
                             alignment: Alignment.topRight,
                             child: Container(
                               width: 80,
                               height: 80,
                               child: Image.network(
                                 data[index].dish_image,
                               ),
                             ),
                           )

                         ],
                       ),

                       Container(
                         child: FittedBox(
                           fit: BoxFit.fill,
                           child: Align(
                             alignment: Alignment.topLeft,
                             child: Text(data[index].dish_description,
                                 style: TextStyle(
                                   fontSize: 15,
                                 )),
                           ),

                         ),
                       ),
                       getItemCount(),
                     ],
                   )

                 ],
               ),
             ),
           ),
         ),
        );
      });
}

Widget getItemCount(){
  int _itemCount = 0;
  return new Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      new FloatingActionButton(
        onPressed: add,
        child: new Icon(Icons.add, color: Colors.black,),
        backgroundColor: Colors.white,),

      new Text('$_n',
          style: new TextStyle(fontSize: 10.0)),

      new FloatingActionButton(
        onPressed: minus,
        child: new Icon(
            const IconData(0xe15b, fontFamily: 'MaterialIcons'),
            color: Colors.black),
        backgroundColor: Colors.white,),
    ],
  );
}

void add() {
  //setState(() {
    _n++;
  //});
}

void minus() {
  //setState(() {
    if (_n != 0)
      _n--;
  //});
}



//_tile(data[index].dish_id, data[index].dish_name, Icons.work),
ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
  title: Text(title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      )),
  subtitle: Text(subtitle),
  leading: Icon(
    icon,
    color: Colors.blue[500],
  ),
);

Future<List<Post>> _fetchJobs() async {

  final jobsListAPIUrl = 'https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad/';
  final response = await http.get(jobsListAPIUrl);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    List jsonResponse1 = jsonResponse[0]['table_menu_list'][0]['category_dishes'];
    return jsonResponse1.map((job) => new Post.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

Future<List<Post>> fetchPosts() async {
  var table;

  http.Response response = await http.get(
      'https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad/');
  var responseJson = json.decode(response.body);
  //print(responseJson.toString());

  print("table "+responseJson[0]['table_menu_list'][0]['category_dishes'].toString());
  categorylist = responseJson[0]['table_menu_list'][0]['category_dishes'];
  print("table1 "+responseJson[0]['table_menu_list'][0]['category_dishes'].length.toString());
  usersList =responseJson[0]['table_menu_list'][0]['category_dishes'].length;

  return categorylist.toList();
}

class Post {
  final String dish_id;
  final String dish_name, dish_price, dish_description, dish_calories, dish_image, updateDate;

  Post({
    this.dish_id,
    this.dish_name,
    this.dish_price,
    this.dish_description,
    this.dish_calories,
    this.dish_image,
    this.updateDate,
  });

  /*factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      temperature: json['temperature'].toString(),
      rain: json['rain'].toString(),
      humidity: json['humidity'].toString(),
      sunrise: json['sunrise'].toString(),
      sunset: json['sunset'].toString(),
      updateDate: json['utcTime'].toString(),
    );
  }*/
  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      dish_id: json['dish_id'].toString(),
      dish_name: json['dish_name'].toString(),
      dish_price: json['dish_price'].toString(),
      dish_description: json['dish_description'].toString(),
      dish_calories: json['dish_calories'].toString(),
      dish_image: json['dish_image'].toString(),
      updateDate: json['dish_description'].toString(),
    );
  }
}