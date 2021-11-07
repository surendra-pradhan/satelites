import 'package:Satelites/detail_page.dart';
import 'package:Satelites/provider/data_provider.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Satellite'),
        ),
        backgroundColor: gradientEndColor,
        body: FutureBuilder(
            future: Provider.of<DataProvider>(context, listen: false)
                .setAndFetchSatelites(),
            builder: (ctx, datasnapshot) => datasnapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<DataProvider>(
                    builder: (ctx, data, child) => ListView.builder(
                        itemCount: data.satelites.length,
                        itemBuilder: (ctx, index) => GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                  DetailPage.routeName,
                                  arguments: data.satelites[index]
                                      ['satelliteId']),
                              child: Card(
                                child: ListTile(
                                  leading: Text(data.satelites[index]['name']),
                                  trailing: Icon(Icons.arrow_right),
                                ),
                              ),
                            )),
                  )));
  }
}
