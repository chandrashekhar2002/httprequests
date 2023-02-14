// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/Model.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  late Model model;
  bool display = false;
  Map<String, dynamic> map={};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: double.maxFinite,
              color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              const url =
                                  "https://63eb1786bfdd4299674132b4.mockapi.io/users";
                              http.Response resp;
                              resp = await http.get(Uri.parse(url));
                              // print(resp.body);
                              try {
                                if (resp.statusCode == 200) {
                                  map = json.decode(resp.body) ;
                                  model = Model.fromJson(map) ;
                                  print(model);
                                  // print(model?.name);
                                  if (model != null) {
                                    setState(() {
                                      display = true;
                                    });
                                  }
                                } else {
                                  print("Error");
                                }
                              } catch (e) {
                                print("Error at : $e ");
                              }
                            },
                            child: Text("GET")),
                        ElevatedButton(onPressed: () {}, child: Text("POST")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: () {}, child: Text("PUT")),
                        ElevatedButton(onPressed: () {}, child: Text("PATCH")),
                        ElevatedButton(onPressed: () {}, child: Text("DELETE")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // This is to display
            callotherwidget(),
          ],
        ),
      ),
    );
  }

  Widget callotherwidget() {
    if (display) {
      return Expanded(
        child: ListView.builder(
          itemCount: model.toString().length,
          itemBuilder: (context, index) {
            // int? id = model?.data![index].id;
            // String? email = model?.data![index].email;
            // String? fname = model?.data![index].firstName;
            // String? lname = model?.data![index].lastName;
            // String? imageurl = model?.data![index].avatar;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 100,
                    width: 100,
                    child: Image.network(model!.avatar.toString())),
                SizedBox(
                  height: 50,
                  width: 80,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(" ID Number : ${model?.id.toString()}"),
                    SizedBox(
                      height: 20,
                    ),
                    Text(" Name  : ${model?.name.toString()}"),
                    SizedBox(
                      height: 20,
                    ),
                    Text(" Created at : ${model?.createdAt.toString()}"),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Divider(),
              ],
            );
          },
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Press GET button to GET API Response"),
            SizedBox(
              height: 20,
            ),
            Text(" Press POST button to Create a new Data"),
            SizedBox(
              height: 20,
            ),
            Text("Press PUT to Update the data"),
            SizedBox(
              height: 20,
            ),
            Text("Press PATCH to Update the data's Specific item"),
            SizedBox(
              height: 20,
            ),
            Text("Press DELETE to Delete the item from data"),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      );
    }
  }
}
