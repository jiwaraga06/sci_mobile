import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:sci_mobile/source/model/StockOpname/modelCutOff.dart';
import 'package:sci_mobile/source/repository/repositoryStockOpname.dart';
import 'package:sci_mobile/source/router/string.dart';

part 'cutof_so_state.dart';

class CutofSoCubit extends Cubit<CutofSoState> {
  final RepositoryStockOpname? repository;
  CutofSoCubit({this.repository}) : super(CutofSoInitial());

  void getCutOf(context) async {
    emit(CutofSoLoading());
    repository!.getCutOf(context).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("\n CUT OF LIST : ${json}");
      EasyLoading.dismiss();
      if (statusCode == 401) {
        EasyLoading.showError("Authorisasi Habis, silahkan login kembali");
        Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
        emit(CutofSoFailed(statusCode: statusCode, json: json));
      } else if (statusCode == 400) {
        emit(CutofSoFailed(statusCode: statusCode, json: json));
      } else {
        emit(CutofSoLoaded(statusCode: statusCode, model: modelCutOfFromJson(jsonEncode(json))));
      }
    });
  }
  void getCutOfCode(context, code) async {
    emit(CutofSoLoading());
    repository!.getCutOfbyNo(context, code) .then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("\n CUT OF CODE : ${json}");
      if (statusCode == 401) {
        EasyLoading.showError("Authorisasi Habis, silahkan login kembali");
        Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
        emit(CutofSoFailed(statusCode: statusCode, json: json));
      } else if (statusCode == 400) {
        emit(CutofSoFailed(statusCode: statusCode, json: json));
      } else {
        emit(CutofSoLoadedSingle(statusCode: statusCode, model: modelCutOfFromJson(jsonEncode(json))));
      }
    });
  }
}
