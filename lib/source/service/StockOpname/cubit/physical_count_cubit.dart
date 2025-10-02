import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:sci_mobile/source/model/StockOpname/modelPhysicalCount.dart';
import 'package:sci_mobile/source/repository/repositoryStockOpname.dart';
import 'package:sci_mobile/source/router/string.dart';

part 'physical_count_state.dart';

class PhysicalCountCubit extends Cubit<PhysicalCountState> {
  final RepositoryStockOpname? repository;
  PhysicalCountCubit({this.repository}) : super(PhysicalCountInitial());

  void getPhysicalCountListSO(context, oid, locationId) async {
    emit(PhysicalCountLoading());
    repository!.getPhysicalCountListSO(context, oid, locationId).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("\n PHYSICAL CODE : ${json}");
      if (statusCode == 401) {
        EasyLoading.showError("Authorisasi Habis, silahkan login kembali");
        Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
        emit(PhysicalCountFailed(statusCode: statusCode, json: json));
      } else if (statusCode == 400) {
        emit(PhysicalCountFailed(statusCode: statusCode, json: json));
      } else {
        emit(PhysicalCountLoaded(statusCode: statusCode, model: modelPhysicalCountFromJson(jsonEncode(json))));
      }
    });
  }

  void clearList(context) {
    emit(PhysicalCountInitial());
  }
}
