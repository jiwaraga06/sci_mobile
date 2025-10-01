import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sci_mobile/source/model/StockOpname/modelLocationSOCode.dart';
import 'package:sci_mobile/source/model/StockOpname/modelLocationSoCodeList.dart';
import 'package:sci_mobile/source/repository/repositoryStockOpname.dart';
import 'package:sci_mobile/source/router/string.dart';

part 'location_so_state.dart';

class LocationSoCubit extends Cubit<LocationSoState> {
  final RepositoryStockOpname? repository;
  LocationSoCubit({this.repository}) : super(LocationSoInitial());

  void getLocationSOList(context, oid) async {
    emit(LocationSoLoading());
    print("loading");
    repository!.getLocationSO(context, oid).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("\n LOCATION LIST : ${json['data']}");
      EasyLoading.dismiss();
      if (statusCode == 401) {
        EasyLoading.showError("Authorisasi Habis, silahkan login kembali");
        Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
        emit(LocationSoFailed(statusCode: statusCode, json: json));
      } else if (statusCode == 400) {
        emit(LocationSoFailed(statusCode: statusCode, json: json));
      } else {
        emit(LocationSoListLoaded(statusCode: statusCode, model: modelLocationCodeSoListFromJson(jsonEncode(json['data']))));
      }
    });
  }

  void getLocationSOCode(context, oid, code) async {
    emit(LocationSoLoading());
    repository!.getLocationSObyCode(context, oid, code).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("\n LOCATION LIST : ${json['data']}");
      EasyLoading.dismiss();
      if (statusCode == 401) {
        EasyLoading.showError("Authorisasi Habis, silahkan login kembali");
        Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
        emit(LocationSoFailed(statusCode: statusCode, json: json));
      } else if (statusCode == 400) {
        emit(LocationSoFailed(statusCode: statusCode, json: json));
      } else {
        emit(LocationSoCodeLoaded(statusCode: statusCode, model: modelLocationCodeSoFromJson(jsonEncode(json['data']))));
      }
    });
  }
}
