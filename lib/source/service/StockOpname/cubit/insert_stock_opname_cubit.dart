import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:sci_mobile/source/repository/repositoryStockOpname.dart';
import 'package:sci_mobile/source/router/string.dart';

part 'insert_stock_opname_state.dart';

class InsertStockOpnameCubit extends Cubit<InsertStockOpnameState> {
  final RepositoryStockOpname? repository;
  InsertStockOpnameCubit({this.repository}) : super(InsertStockOpnameInitial());

  void save(context, oid, locationId, palletId, qty) async {
    emit(InsertStockOpnameLoading());
    var body = {"location_id": "$locationId", "pallet_id": "$palletId", "qty": "$qty"};
    print("BODY: $body");
    repository!.saveSO(context, oid, jsonEncode(body)).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 401) {
        EasyLoading.showError("Authorisasi Habis, silahkan login kembali");
        Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
        emit(InsertStockOpnameFailed(statusCode: statusCode, json: {}));
      } else if (statusCode == 400) {
        var json = jsonDecode(value.body);
        emit(InsertStockOpnameFailed(statusCode: statusCode, json: json));
      } else if (statusCode == 200 || statusCode == 201) {
        var json = jsonDecode(value.body);
        emit(InsertStockOpnameLoaded(statusCode: statusCode, json: json));
      }
    });
  }
}
