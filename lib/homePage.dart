import 'dart:ui';
import 'package:CoronaCount/API/FutureApi.dart';
import 'package:CoronaCount/Regional.dart';
import 'package:flutter/material.dart';
import 'ClassForCasses.dart' as globals;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FutureApi futureModel = FutureApi();
  Box friendBox;
  var value;
  Map god;
  int i1 = 0, i2 = 0, i3 = 0, i4 = 0, i5 = 0;
  Color newColor;
  Future func() async {
    var gal = await futureModel.getValue();
    god = futureModel.vare();
    setState(() {
      value = gal;
      int top1 = 0, top2 = 0, top3 = 0, top4 = 0, top5 = 0;
      for (int i = 0; i < god["Countries"].length; i++) {
        {
          if (top1 < god["Countries"][i]["TotalConfirmed"]) {
            top1 = god["Countries"][i]["TotalConfirmed"];
            i1 = i;
          }
        }
      }
      for (int i = 0; i < god["Countries"].length; i++) {
        if (top2 < god["Countries"][i]["TotalConfirmed"] &&
            god["Countries"][i]["TotalConfirmed"] < top1) {
          top2 = god["Countries"][i]["TotalConfirmed"];
          i2 = i;
        }
      }
      for (int i = 0; i < god["Countries"].length; i++) {
        if (top3 < god["Countries"][i]["TotalConfirmed"] &&
            god["Countries"][i]["TotalConfirmed"] < top2) {
          top3 = god["Countries"][i]["TotalConfirmed"];
          i3 = i;
        }
      }
      for (int i = 0; i < god["Countries"].length; i++) {
        if (top4 < god["Countries"][i]["TotalConfirmed"] &&
            god["Countries"][i]["TotalConfirmed"] < top3) {
          top4 = god["Countries"][i]["TotalConfirmed"];
          i4 = i;
        }
      }
      for (int i = 0; i < god["Countries"].length; i++) {
        if (top5 < god["Countries"][i]["TotalConfirmed"] &&
            god["Countries"][i]["TotalConfirmed"] < top4) {
          top5 = god["Countries"][i]["TotalConfirmed"];
          i5 = i;
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    func();
    friendBox=Hive.box("Storage");
  }

  @override
  Widget build(BuildContext context) {
    return (value != null)
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[800],
              centerTitle: true,
              title: Text("Covid Tracker"),
              
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("WorldWide",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blueGrey[800],
                                      fontWeight: FontWeight.bold)),
                              new RaisedButton(
                                padding: const EdgeInsets.all(8.0),
                                textColor: Colors.white,
                                color: Colors.blueGrey[800],
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Regional()));
                                },
                                child: new Text("Regional"),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 220,
                            child: GridView.count(
                                childAspectRatio: 2,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                children: [
                                  UserContainer(
                                      value.global.totalConfirmed.toString(),
                                      "CONFIRMED",
                                      Colors.red[100],
                                      Colors.red),
                                  UserContainer(
                                      value.global.newConfirmed.toString(),
                                      "ACTIVE",
                                      Colors.blue[100],
                                      Colors.blue),
                                  UserContainer(
                                      value.global.totalRecovered.toString(),
                                      "RECOVERED",
                                      Colors.green[100],
                                      Colors.green),
                                  UserContainer(
                                      value.global.totalDeaths.toString(),
                                      "DEATHS",
                                      Colors.black38,
                                      Colors.black),
                                ])),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Selected Region',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.bold)),
                            IconButton(
                                icon: Icon(Icons.refresh),
                                onPressed: () {
                                  setState(() {
                                    print(globals.val1.length);
                                    print(friendBox.get("country").length);
                                    print(friendBox.get("country").toString());
                                  });
                                })
                          ],
                        )),
                        (friendBox.get("country").length > 0)
                            ? Container(
                              width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                         for(var item in friendBox.get("country") ) 
                                        ((item!=null)?SelectedCountry(item):Text("hello")),
                                    /*children: globals.val1
                                        .map((e) => SelectedCountry(e))
                                        .toList(),*/],
                                        ),
                              )
                            : Container(
                              color: Colors.white,
                                height: 50,
                                child: Center(child:Text("no selected region")),
                              ),
                        Text("Top Most 5 Affected Countries",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blueGrey[800],
                                fontWeight: FontWeight.bold)),
                        CountriesContainer(i1),
                        CountriesContainer(i2),
                        CountriesContainer(i3),
                        CountriesContainer(i4),
                        CountriesContainer(i5),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            color: Colors.blueGrey[800],
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0,right:8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('data'),
                                  IconButton(
                                      icon: Icon(Icons.arrow_forward_ios),
                                      onPressed: (){
                                        })
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            color: Colors.blueGrey[800],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('data'),
                                IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: null)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            color: Colors.blueGrey[800],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('data'),
                                IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: null)
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(),
          );
  }

  Widget UserContainer(String e, String val, Color good, Color text1) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(5),
          color: good,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(val,
                  style: TextStyle(
                      color: text1, fontWeight: FontWeight.bold, fontSize: 15)),
              Text(e,
                  style: TextStyle(
                      color: text1, fontWeight: FontWeight.bold, fontSize: 15))
            ]),
      ),
    );
  }

  Widget CountriesContainer(int q) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Container(
          color: Colors.white,
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(
                  "https://www.countryflags.io/${god["Countries"][q]["CountryCode"]}/flat/64.png"),
              SizedBox(width: 10),
              Text(
                god["Countries"][q]["Country"],
                style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              SizedBox(width: 10),
              Text(
                god["Countries"][q]["TotalConfirmed"].toString(),
                style: TextStyle(
                    color: Colors.red[200],
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )
            ],
          )),
    );
  }

  Widget SelectedCountry(g) {
    Map e=friendBox.get("${g}");
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 2.0,
                  spreadRadius: 1,
                  offset: Offset(
                    0.0,
                    5.0,
                  ))
            ],
          ),
          height: 165,
          width: MediaQuery.of(context).size.width,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            (e["country"]!=null)?"${e["country"]}":"hello",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 80,
                            child: Image.network(
                              "https://www.countryflags.io/${e["countryCode"]}/flat/64.png",
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((e["country"]!=null)?"TotalConfirmed: ${e["totalConfirmed"]}":"hello",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold)),
                        Text((e["country"]!=null)?"NewConfirmed: ${e["newConfirmed"]}":"hello",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold)),
                        Text((e["country"]!=null)?"TotalDeaths: ${e["totalDeaths"]}":"hello",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text((e["country"]!=null)?"TotalRecovered: ${e["totalRecovered"]}":"hello",
                            style: TextStyle(
                                color: Colors.green, fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              ),
              IconButton(icon: Icon(Icons.delete), onPressed: ()
              {
                setState(() {
                  globals.val1.remove(e);
                  List dummy =friendBox.get("country");
                  dummy.remove(g);
                  friendBox.put("country", dummy);
                  friendBox.delete(g);
                });
              })
            ],
          ),
  
      ),
    );
  }
  _countryList()
  {
    for(int i=0;i<10;i++)
    {

    }

  }
}
