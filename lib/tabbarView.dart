import 'dart:convert';
import 'dart:async';
import 'package:flutterinterviewtest/cartview.dart';
import 'package:flutterinterviewtest/main.dart';
import 'package:flutterinterviewtest/mylist.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyAppTabBar());

var categorylist = new List<Post>();
int _n = 0;
int quantity = 0;
bool visible =  true;
List<Post> products1 = [];
List<TextEditingController> _quantityController = new List();

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);
double val =0.0;
class MyAppTabBar extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: MyHomePageTabBar(),
    );
  }
}

class MyHomePageTabBar extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageTabBar> {
  int _itemCount = 0;

  @override
  void initState() {
    super.initState();
    getItemCount();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
          title: Text(''),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => new MyAppCartView(products1,val)),
                      );

                  },
                  child: Icon(
                    Icons.shopping_cart,
                    size: 26.0,
                  ),
                )
            ),

          ],

        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  "Welcome !!",
                  textAlign: TextAlign.justify,
                  textScaleFactor: 2.0,
                ),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              ListTile(
                title: Text("Logout"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyApp()));
                },
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: [
            getSaladWidg(context, 0),
            getSaladWidg(context, 1),
            getSaladWidg(context, 2),
            getSaladWidg(context, 3),
            getSaladWidg(context, 4),
            getSaladWidg(context, 5),
          ],
        ),
      ),
    );
  }


  Widget getSaladWidg(context, int io) {
    return FutureBuilder<List<Post>>(
      future: _fetchJobs(io),
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


  ListView _jobsListView(data) {
    int valss = 0;
    int pagenumber = 5;

    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          _quantityController.add(new TextEditingController());
          int valfdssf = data[index].dish_addcaart.toString().length;
          print("data[index].dish_name " +valfdssf.toString());
          return Stack(
            children: [
              Column(
                children: [
                  Padding(padding: EdgeInsets.all(5),),
                  Material(
                    child: Container(
                        decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(), ),
                        child: InkWell(
                          onTap: () {

                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            height: 250,
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
                                        Text("INR " + data[index].dish_price,
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

                                    //getItemCount(),
                                    Padding(padding: EdgeInsets.all(5),),

                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: 150,
                                        decoration: BoxDecoration(color: Colors.green,
                                          border: Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0) //         <--- border radius here
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: IconButton(
                                                icon: new Icon(Icons.remove,color: Colors.white,),
                                                iconSize: 20,
                                                onPressed: () => setState(() {
                                                  if (data[index].updateDate != 0)
                                                    _n = data[index].updateDate--;
                                                }),
                                              ),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '$_n',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white
                                                ),
                                              ),
                                              flex: 1,
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                  icon: new Icon(Icons.add,color: Colors.white,),
                                                  padding: const EdgeInsets.all(0),
                                                  iconSize: 20,
                                                  onPressed: () =>
                                                      setState(() {
                                                        _n= data[index].updateDate++;
                                                        data[index].updateDate++;

                                                        double value = double.parse(data[index].dish_price);
                                                        val =val+value;
                                                        ///int valss = int.parse(val);

                                                        Post myProduct = Post(dish_id: data[index].dish_id,
                                                            dish_name: data[index].dish_name,
                                                            dish_price: data[index].dish_price,
                                                            dish_calories: data[index].dish_calories,
                                                            dish_description: data[index].dish_description,
                                                            dish_image: data[index].dish_image,total:val);
                                                        print("myProduct " + myProduct.dish_name);

                                                        products1.add(myProduct);
                                                        print("myProduct " + products1.length.toString());

                                                      } )),
                                              flex: 1,
                                            )
                                          ],
                                        ),
                                      ),
                                    )

                                   /* Padding(padding: EdgeInsets.all(5),),

                                    Divider(
                                      color: Colors.black,
                                    )*/
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),

                  ),

                ],
              )
            ],
          );
        });
  }

  int _itemCount1 = 0;
  Widget getItemCount() {

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
    /*return new Row(
      children: <Widget>[
        //_itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
        new IconButton(icon: new Icon(Icons.remove),
          onPressed: () => setState(() => _itemCount1--),),
        new Text(_itemCount1.toString()),
        new IconButton(icon: new Icon(Icons.add),
            onPressed: () => setState(() => _itemCount1++))
      ],
    );*/
  }

}

Future<List<Post>> _fetchJobs(int io) async {

  final jobsListAPIUrl = 'https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad/';
  final response = await http.get(jobsListAPIUrl);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    List jsonResponse1 = jsonResponse[0]['table_menu_list'][io]['category_dishes'];
    //jsonResponse1.add("dataValue");
    return jsonResponse1.map((job) => new Post.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}


class Post {
  final String dish_id;
  final String dish_name, dish_price, dish_description, dish_calories, dish_image,dish_addcaart;
  int updateDate;
  double total;

  Post({
    this.dish_id,
    this.dish_name,
    this.dish_price,
    this.dish_description,
    this.dish_calories,
    this.dish_image,
    this.dish_addcaart,
    this.updateDate,
    this.total,
  });


  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      dish_id: json['dish_id'].toString(),
      dish_name: json['dish_name'].toString(),
      dish_price: json['dish_price'].toString(),
      dish_description: json['dish_description'].toString(),
      dish_calories: json['dish_calories'].toString(),
      dish_image: json['dish_image'].toString(),
      dish_addcaart: json['addonCat'].toString(),
      updateDate: int.parse(json['dish_Type'].toString()),
      total: 0.0,
    );
  }
}