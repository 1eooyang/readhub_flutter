import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readhub/app/ui/NewsItemView.dart';
import 'package:readhub/app/ui/main/FirstPage.dart';

class SecondPage extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    return new FirstPageState();
  }
}

class FirstPageState extends State<SecondPage> {
  List data;

  @override
  void initState() {
    super.initState();
    getJSONData();
  }

  Future<String> getJSONData() async {
    final url = "https://api.readhub.me/topic?pageSize=100";
    print(url);
    var response = await http.get(
        // Encode the url
        Uri.encodeFull(url),
        // Only accept JSON response
        headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      var dataConvertedToJSON = JSON.decode(response.body);
      data = dataConvertedToJSON['data'];
    });

    return "Successfull";
  }

  @override
  Widget build(BuildContext context) {
    Widget listWidget = new ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return new NewsItemView(
            data[index]["title"],
            data[index]["publishDate"],
            data[index]["newsArray"][0]["mobileUrl"]);
      },
      itemCount: data == null ? 0 : data.length,
    );

    return listWidget;
  }
}
