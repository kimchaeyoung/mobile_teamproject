import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:team_project/home.dart';
import 'package:team_project/login.dart';
import 'package:team_project/locator.dart';
import 'package:team_project/viewModel.dart';
import 'package:team_project/route.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    WidgetsFlutterBinding.ensureInitialized();
    setupLocator();


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<ViewModel>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MasterChefChellenge',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: HomePage(),
        initialRoute: '/login',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}