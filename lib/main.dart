import 'package:CoronaCount/homePage.dart';
import "package:flutter/material.dart";
import 'package:CoronaCount/name_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'ClassForCasses.dart' as globals;
void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory document= await getApplicationDocumentsDirectory();
  print("hai");
  Hive.init(document.path);
  await Hive.openBox("Storage");
  Box hello =Hive.box("Storage");
  hello.put("country", []);
  if(hello.get("country").length<=0)
  {
    print("hai");
    hello.put("country", []);
  }

/*  hello.put("India", {"country":'e.country',
                            "countryCode": 'IN',
                            "slug": 'e.slug',
                            "totalRecovered": 'e.totalRecovered',
                            "totalConfirmed": 'e.totalConfirmed',
                            "newRecovered": 'e.newRecovered',
                            "totalDeaths": 'e.totalDeaths',
                            "newConfirmed": 'e.newConfirmed',
                            "newDeaths": 'e.newDeaths',
                            "date": 'e.date'
                            });*/
  globals.Country1= hello.get("country");
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        
        fontFamily: 'Circular',
      ),
      home:HomePage(),
    ),);
 

}