import 'package:flutter/material.dart';

class Name_page extends StatefulWidget {
  @override
  _Name_pageState createState() => _Name_pageState();
}

class _Name_pageState extends State<Name_page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('lib/Images/corona.png'),
                backgroundColor: Colors.white,
                maxRadius: 140,
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green,
                          blurRadius: 3.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                              3.0, 3.0), // shadow direction: bottom right
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: 'E-mail or Username'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green,
                          blurRadius: 3.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                              3.0, 3.0), // shadow direction: bottom right
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                  ),
                ),
              )
              ,SizedBox(height:50),
              Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green,
                        blurRadius: 3.0,
                        spreadRadius: 1.0,
                        offset:
                            Offset(3.0, 3.0), // shadow direction: bottom right
                      )
                    ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Retype password'),
                ),
                  ),
              ),
            )
            ],
          ),
        ),
      )),
    );
  }
}
