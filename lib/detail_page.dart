import 'package:Satelites/constants.dart';
import 'package:Satelites/provider/data_provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  static const routeName = "/detailPage";

  const DetailPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final satID = ModalRoute.of(context).settings.arguments;
    final satData = Provider.of<DataProvider>(context, listen: false)
        .setandfetchSateliteDetails(satID);

    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<DataProvider>(context, listen: false)
            .setandfetchSateliteDetails(satID),
        builder: (ctx, datasnapshot) => datasnapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                bottom: false,
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Consumer<DataProvider>(
                        builder: (ctx, data, child) => Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 300),
                                  Text(
                                    data.satelite['name'],
                                    style: TextStyle(
                                      fontSize: 38.0,
                                      fontWeight: FontWeight.w900,
                                      color: primaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMMMd().format(
                                        DateFormat("yyyy-MM-dd")
                                            .parse(data.satelite['date'])),
                                    style: TextStyle(
                                      fontSize: 31.0,
                                      color: primaryTextColor,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Divider(color: Colors.black38),
                                  SizedBox(height: 32.0),
                                ],
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 32.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await canLaunch(
                                            'https://tle.ivanstanojevic.me/#/tle/$satID')
                                        ? await launch(
                                            'https://tle.ivanstanojevic.me/#/tle/$satID')
                                        : throw 'https://tle.ivanstanojevic.me/#/tle/$satID';
                                  },
                                  child: Text('Map View'),
                                )),
                          ],
                        ),
                      ),
                    ),
                    // Positioned(
                    //   right: -64,
                    //   child: Hero(
                    //     tag: planetInfo.position,
                    //     child: Image.asset(planetInfo.iconImage),
                    //   ),
                    // ),
                    Positioned(
                      child: Consumer<DataProvider>(
                        builder: (ctx, data, child) => Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 60,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Line1 :',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: primaryTextColor.withOpacity(1),
                                      fontWeight: FontWeight.w900,
                                    )),
                                TextSpan(
                                    text: data.satelite['line1'],
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: primaryTextColor.withOpacity(1),
                                      fontWeight: FontWeight.w900,
                                    ))
                              ])),
                              SizedBox(
                                height: 30,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: 'Line1 :',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: primaryTextColor.withOpacity(1),
                                      fontWeight: FontWeight.w900,
                                    )),
                                TextSpan(
                                    text: data.satelite['line2'],
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: primaryTextColor.withOpacity(1),
                                      fontWeight: FontWeight.w900,
                                    ))
                              ])),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
