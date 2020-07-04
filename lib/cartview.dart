//Display ListView in here
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterinterviewtest/tabbarView.dart';

class MyAppCartView extends StatelessWidget {
  final List<Post> trails;
  final double total;

  MyAppCartView(this.trails,this.total);
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("order summary"),
      ),
      body:TrailList(trails,total),
    );
  }
}

//create ListView here which I want displayed on 2nd page
class TrailList extends StatelessWidget {
  final List<Post> trails;

  final double total;

  TrailList(this.trails, this.total);
  double val =0.0;
  double values =0.0;
  Widget build(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          Column(
            children: [
              new Material(
                child: Card(
                  margin: EdgeInsets.all(20),
                  child:Column(
                    children: [
                      Container(
                        color: Colors.green,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dishes",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                )),
                            Text("-",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                )),
                            Text("Items",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                )),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10),),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: trails.length,
                        itemBuilder: (context, int index) {
                          String myText = trails[index].dish_name;
                          double value = double.parse(trails[index].dish_price);
                          values = trails[index].total;
                          print(myText);
                          print("values " +values.toString());
                          val =val+value;
                          print(val);
                          /*var splitString = myText.split("\, type");
                        var splitString2 = splitString[0];
                        var splitString3 = splitString2.split("name: ");
                        String name = splitString3[1];

                        splitString = myText.split("\, name");
                        splitString2 = splitString[0];
                        splitString3 = splitString2.split("id: ");
                        String id = splitString3[1];

                        splitString = myText.split("\, conditionStatus");
                        splitString2 = splitString[0];
                        splitString3 = splitString2.split("latitude: ");
                        String latitude = splitString3[1];
                        splitString = myText.split("\, latitude");
                        splitString2 = splitString[0];
                        splitString3 = splitString2.split("longitude: ");
                        String longitude = splitString3[1];
                        splitString = myText.split("\, url");
                        splitString2 = splitString[0];
                        splitString3 = splitString2.split(" location: ");
                        String location = splitString3[1];*/


                          /*return _tile(myText, myText, Icons.wallpaper);*/
                          return Material(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              padding: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 150,
                                              child: Wrap(
                                                children: [
                                                  Text(trails[index].dish_name,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 20,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 100,
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
                                                    ),
                                                    flex: 1,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '0',
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
                                                    ),
                                                    flex: 1,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(trails[index].dish_price,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                )),
                                          ],
                                        ),

                                        /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(trails[index].dish_name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      )),
                                ),*/

                                        Padding(padding: EdgeInsets.all(5),),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("INR "+trails[index].dish_price,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                )),


                                          ],
                                        ),

                                        Padding(padding: EdgeInsets.all(5),),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(trails[index].dish_calories+" calories",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                              )),
                                        ),

                                        Divider(),
                                        //dkfndskfnkldsnfklds
                                      ],
                                    )

                                  ],
                                ),
                              ),
                            ),

                          );
                        },
                      ),
                      getTotalWidget(val),

                    ],
                  )
                  ,
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: placeOrder(context),
              ),
            ],
          ),

        ],
      ),
    );
  }

 Widget getTotalWidget (double val){
   return Container(
     padding: EdgeInsets.all(10),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Text("Total Amount",
             style: TextStyle(
               fontWeight: FontWeight.w500,
               fontSize: 20,
             )),
         Text(total.toString(),
             style: TextStyle(
               fontWeight: FontWeight.w500,
               fontSize: 20,
             )),

       ],
     ),
   );
 }

  Future<String> asyncFunc1() async {
    return "async return1";
  }

 Widget placeOrder(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(color: Colors.green,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(
              Radius.circular(30.0) //         <--- border radius here
          ),
        ),
        width: 200,
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: (){
             final snackBar = SnackBar(content: Text("Tap"));

             Scaffold.of(context).showSnackBar(snackBar);
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new MyAppTabBar()),
            );
          },
          
          child: Text(
            'Place Order',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
 }

}



