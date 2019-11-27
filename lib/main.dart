import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:team_project/app.dart';

void main(){
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}