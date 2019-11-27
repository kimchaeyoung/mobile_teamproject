import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Recipe {
  String id;
  String name;
  int level;
  String imgurl;
  final List<dynamic> reviews;
  final List<dynamic> ingredient;
  final List<dynamic> recipe;

  Recipe({this.id, this.name, this.level, this.imgurl, this.reviews, this.ingredient, this.recipe});


  Recipe.fromMap(Map snapshot,String id) :
        id = id,
        name = snapshot['name'] ?? '',
        level = snapshot['level'] ?? 0,
        imgurl = snapshot['imgurl'] ?? 'https://firebasestorage.googleapis.com/v0/b/master-chef-challenge.appspot.com/o/not-available.jpg?alt=media&token=4658174e-f107-48a4-86f7-ec7e45ce42eb',
        reviews = snapshot['reviews'],
        ingredient = snapshot['ingredient'],
        recipe = snapshot['recipe'];


  toJson() {
    return {
      "id": id,
      "name": name,
      "level": level,
      "imgurl": imgurl,
      "reviews": reviews,
      "ingredient": ingredient,
      "recipe": recipe,
    };
  }

}
