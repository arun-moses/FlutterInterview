import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterinterviewtest/cartview.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(TabBarDemo());
}
var categorylist = new List<Post1>();
int _n = 0;
List<Post1> products = [];


class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Salads and Soup",
                ),
                Tab(
                  text: "From The Barnyard",
                ),
                Tab(
                  text: "From the Hen House",
                ),
                Tab(
                  text: "Fresh From The Sea",
                ),
                Tab(
                  text: "Biryani",
                ),
                Tab(
                  text: "Fast Food",
                ),
              ],
            ),
            title: Text('Tabs Demo'),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      /*Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => new MyAppCartView(products)),
                      );*/


                    },
                    child: Icon(
                      Icons.shopping_cart,
                      size: 26.0,
                    ),
                  )
              ),
              /*Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                        Icons.more_vert
                    ),
                  )
              ),*/
            ],
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                /*ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),*/
              ],
            ),
          ),
          body: TabBarView(
            children: [
              getSaladWidg(context,0),
              getSaladWidg(context,1),
              getSaladWidg(context,2),
              getSaladWidg(context,3),
              getSaladWidg(context,4),
              getSaladWidg(context,5),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSaladWidg(context,int io){
   return FutureBuilder<List<Post1>>(
      future: _fetchJobs(io),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post1> data = snapshot.data;
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
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Material(
          child: Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: InkWell(
                onTap: (){

                  Post1 myProduct = Post1(dish_id:data[index].dish_id,dish_name: data[index].dish_name, dish_price: data[index].dish_price, dish_calories: data[index].dish_calories,dish_description: data[index].dish_description,dish_image: data[index].dish_image);
                  print("myProduct "+myProduct.dish_name);

                  products.add(myProduct);
                  print("myProduct "+products.length.toString());

                },
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
          ),
        );
      });
}

Widget getItemCount(){
  int _itemCount = 0;
  /*return new Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      new FloatingActionButton(
        onPressed: adds,
        child: new Icon(Icons.add, color: Colors.black,),
        backgroundColor: Colors.white,),

      new Text('$_n',
          style: new TextStyle(fontSize: 20.0)),

      new FloatingActionButton(
        onPressed: minus,
        child: new Icon(
            const IconData(0xe15b, fontFamily: 'MaterialIcons'),
            color: Colors.black),
        backgroundColor: Colors.white,),
    ],
  );*/
  return new Row(
    children: <Widget>[
      //_itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
      /*new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),),
      new Text(_itemCount.toString()),
      new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))*/
    ],
  );
}



void adds() {
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


Future<List<Post1>> _fetchJobs(int io) async {

  final jobsListAPIUrl = 'https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad/';
  final response = await http.get(jobsListAPIUrl);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    List jsonResponse1 = jsonResponse[0]['table_menu_list'][io]['category_dishes'];
    return jsonResponse1.map((job) => new Post1.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}


class Post1 {
  final String dish_id;
  final String dish_name, dish_price, dish_description, dish_calories, dish_image, updateDate;

  Post1({
    this.dish_id,
    this.dish_name,
    this.dish_price,
    this.dish_description,
    this.dish_calories,
    this.dish_image,
    this.updateDate,
  });

  factory Post1.fromJson(Map<String, dynamic> json) {
    return new Post1(
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

class NextPage extends StatefulWidget {
  final String value;

  NextPage(String s, {Key key, this.value}) : super(key: key);

  @override
  _NextPageState createState() => new _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Next Page"),
      ),
      body: new Text("${widget.value}"),
    );
  }
}