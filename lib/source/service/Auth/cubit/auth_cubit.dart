import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sci_mobile/source/repository/repositoryAuth.dart';
import 'package:sci_mobile/source/router/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RepositoryAuth? repository;
  AuthCubit({this.repository}) : super(AuthInitial());

  void session(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var tokenExpire = pref.getString("tokenExpire");
    await Future.delayed(const Duration(seconds: 2));
    print(token);
    if (token != null) {
      var format = DateFormat('yyyy-MM-dd');
      var datetime = format.parse(DateTime.now().toString());
      var datetimeExpire = DateTime.parse(tokenExpire!);
      print(datetime);
      print(datetimeExpire);
      if (datetime.isBefore(datetimeExpire)) {
        print("belum expire");
        Navigator.pushNamedAndRemoveUntil(context, dashboardScreen, (route) => false);
      } else {
        EasyLoading.showError("Authorisasi Habis, silahkan login kembali");
        Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
        print("sudah expire");
        // pref.clear();
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
    }
  }

  void login(username, password, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    emit(Authloading());
    var body = {"user_id": "$username", "password": "$password"};
    print(body);
    repository!.login(jsonEncode(body), context).then((value) {
      var statusCode = value.statusCode;
      var json = jsonDecode(value.body);
      print("LOGIN: $json");
      print(statusCode);
      if (statusCode == 200) {
        var format = DateFormat('yyyy-MM-dd');
        pref.setString("token", json['access_token']);
        pref.setString("username", json['user_id']);
        pref.setString("tokenExpire", format.format(DateTime.parse(json['expires_at_utc'])).toString());
      }
      emit(Authloaded(statusCode: statusCode, json: json));
    });
  }

  void logout(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
  }
}
