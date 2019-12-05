import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:team_project/locator.dart';
import 'package:team_project/api.dart';
import 'package:team_project/recipe.dart';

class ViewModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Recipe> recipes;


  Future<List<Recipe>> fetchRecipes() async {
    var result = await _api.getDataCollection();
    recipes = result.documents
        .map((doc) => Recipe.fromMap(doc.data, doc.documentID))
        .toList();
    return recipes;
  }

  Stream<QuerySnapshot> fetchRecipesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Recipe> getRecipeById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Recipe.fromMap(doc.data, doc.documentID) ;
  }


  Future removeRecipe(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateRecipe(Recipe data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

//  Future addRecipe(Recipe data) async{
//    var result  = await _api.addDocument(data.toJson()) ;
//
//    return ;
//
//  }


}