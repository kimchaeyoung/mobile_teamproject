import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:team_project/login.dart';
import 'package:team_project/home.dart';
import 'package:team_project/mypage.dart';
import 'package:team_project/list.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login' :
        return  MaterialPageRoute(
            builder: (_)=> LoginPage()
        );
      case '/' :
        return  MaterialPageRoute(
            builder: (_)=> HomePage()
        );
      case '/mypage' :
        return MaterialPageRoute(
            builder: (_)=> MyPage()
        ) ;
      case '/listrecipe' :
        return MaterialPageRoute(
            builder: (_)=> ListRecipe()
        ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}