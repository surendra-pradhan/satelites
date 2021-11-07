import 'package:Satelites/detail_page.dart';
import 'package:Satelites/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: DataProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'satelites',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {DetailPage.routeName: (ctx) => DetailPage()},
      ),
    );
  }
}
