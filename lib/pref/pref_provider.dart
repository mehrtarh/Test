import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job/store/base_store_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrefProviderAbstract {

  Future<String> getFirstName();
  Future<String> getLastName() ;
  Future<bool> getLoginStatus() ;

  void setFirstName(String value);

  void setLastName(String value);

  void setLoginStatus(bool status);

  Future<bool> writeModelInJson(dynamic body, String url, Duration duration) ;

  Future<Map<String,dynamic>> getModelString(String url,bool removeModelByTime) ;
}

class PrefProvider implements PrefProviderAbstract {
  static final String firstName = "firstName";
  static final String lastName = "lastName";
  static final String loginStatus = "loginStatus";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  PrefProvider();

  Future<String> getFirstName() async {
    SharedPreferences pref = await _prefs;

    return pref != null &&
        pref.containsKey(firstName) &&
        pref.getString(firstName) != null
        ? pref.getString(firstName)
        : "";
  }

  Future<String> getLastName() async {
    SharedPreferences pref = await _prefs;

    return pref != null &&
        pref.containsKey(lastName) &&
        pref.getString(lastName) != null
        ? pref.getString(lastName)
        : "";
  }
  Future<bool> getLoginStatus() async {
    SharedPreferences pref = await _prefs;

    return pref != null && pref.containsKey(loginStatus) && pref.getBool(loginStatus) != null
        ? pref.getBool(loginStatus)
        : false;
  }

  void setFirstName(String value){
    _prefs.then((pref) => pref.setString(firstName, value));
  }

  void setLastName(String value){
    _prefs.then((pref) => pref.setString(lastName, value));
  }

  void setLoginStatus(bool status){
    _prefs.then((pref) => pref.setBool(loginStatus, status));
  }




  Future<bool> writeModelInJson(dynamic body, String url, Duration duration) async {
    SharedPreferences pref = await _prefs;
    if (duration == null)
      return false;
    else {
      BaseStoreModel local = BaseStoreModel(model: body, time: DateTime.now().add(duration));
      final json = jsonEncode(local.toJson());
      if (body != null && json.isNotEmpty) {
        return await pref.setString(url, json);
      }
      return false;
    }
  }

  Future<Map<String,dynamic>> getModelString(String url,bool removeModelByTime) async {

    SharedPreferences pref = await _prefs;
    final jsonString = pref.getString(url);
    if (jsonString != null) {
      final jsonModel = jsonDecode(jsonString);
      final model = BaseStoreModel.fromJson(jsonModel);
      if(removeModelByTime) {
        if (DateTime.now().isBefore(model.time))
          return BaseStoreModel
              .fromJson(jsonModel)
              .model;
      }else
        return BaseStoreModel
            .fromJson(jsonModel)
            .model;
    }
    return null;
  }
}
