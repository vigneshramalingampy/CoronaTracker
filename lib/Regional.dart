
import 'package:CoronaCount/SelectedCountryDesign.dart';
import 'package:CoronaCount/homePage.dart';
import 'package:flutter/material.dart';
import 'API/ModelApi.dart';
import 'API/FutureApi.dart';
import 'ClassForCasses.dart' as globals;
import 'SelectedCountryDesign.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';


class Regional extends StatefulWidget {
  @override
  _RegionalState createState() => _RegionalState();
}

class _RegionalState extends State<Regional> {
  Future futureApi;
  FutureApi futureModel = FutureApi();
  HomePage homePage = HomePage();
  int i = 0;
  int j = 0;
Box friendBox;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    friendBox = Hive.box("Storage");
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: new SingleChildScrollView(
            child: FutureBuilder(
              builder: (context, snapshot) {
                ModelApi data = snapshot.data;
                if (snapshot.hasData)
                  return new Column(
                    children:
                        data.countries.map((e) => containerFunc(e)).toList(),
                  );
                else {
                  return SafeArea(
                    child: SingleChildScrollView(),
                  );
                }
              },
              future: futureModel.getValue(),
            ),
          )),
    );
  }

  Widget containerFunc(e) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400],
                blurRadius: 2.0,
                spreadRadius: 1.0,
                offset: Offset(
                  0.0,
                  5.0,
                ))
          ],
        ),
        height: 165,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    child: Column(
                      children: [
                        Text(
                          "${e.country}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 80,
                          child:Image.network(
                            "https://www.countryflags.io/${e.countryCode}/flat/64.png",
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
                      Text("CONFIRMED:${e.totalConfirmed}",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                      Text("NEW CASES:${e.newConfirmed.toString()}",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                      Text("TOTAL DEATH:${e.totalDeaths.toString()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text("TOTAL RECOVERED:${e.totalRecovered.toString()}",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  new FloatingActionButton(
                    heroTag: 'b${i++}',
                    onPressed: (){
                        if (!globals.Country1.contains(e.country)) {

                          print(globals.Country1);
                          globals.Country1.add(e.country);
                          _toastFunc("Country added to home screen");

                          Map val={"country":e.country,
                            "countryCode": e.countryCode,
                            "slug": e.slug,
                            "totalRecovered": e.totalRecovered,
                            "totalConfirmed": e.totalConfirmed,
                            "newRecovered": e.newRecovered,
                            "totalDeaths": e.totalDeaths,
                            "newConfirmed": e.newConfirmed,
                            "newDeaths": e.newDeaths,
                            "date": e.date
                            };
                          friendBox.put("${e.country}", val);
                          print("hello:"+friendBox.get("${e.country}").toString());

                          friendBox.put("country", globals.Country1);

                          globals.val1.add(SelectedCountryDesign(
                            country: e.country,
                            countryCode: e.countryCode,
                            slug: e.slug,
                            totalRecovered: e.totalRecovered,
                            totalConfirmed: e.totalConfirmed,
                            newRecovered: e.newRecovered,
                            totalDeaths: e.totalDeaths,
                            newConfirmed: e.newConfirmed,
                            newDeaths: e.newDeaths,
                            date: e.date,
                          ));
                          print(globals.val1[j++].country);
                        } else {
                          _toastFunc("Already exist in Home Page");
                        }
                      
                    },
                    child: Icon(Icons.add),
                    backgroundColor: Colors.lightBlue[200],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  new FloatingActionButton(
                    heroTag: 'b${i++}',
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: new Text("${e.country}"),
                              content: Container(
                                height: 250,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "countryCode:${e.countryCode.toString()}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                        "totalConfirmed:${e.totalConfirmed.toString()}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                        "newConfirmed:${e.newConfirmed.toString()}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text("newDeaths:${e.newDeaths.toString()}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                        "totalDeaths:${e.totalDeaths.toString()}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                        "newRecovered:${e.newRecovered.toString()}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                        "totalRecovered:${e.totalRecovered.toString()}"),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text("DATE:${e.date.toString()}"),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog

                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Icon(Icons.date_range),
                    backgroundColor: Colors.yellow[400],
                  ),
                  SizedBox(
                    width: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  _toastFunc(text)
  {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }
}
