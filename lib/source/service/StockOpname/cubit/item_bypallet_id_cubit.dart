import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:sci_mobile/source/model/StockOpname/modelItembyPalletID.dart';
import 'package:sci_mobile/source/repository/repositoryStockOpname.dart';
import 'package:sci_mobile/source/router/string.dart';

part 'item_bypallet_id_state.dart';

class ItemBypalletIdCubit extends Cubit<ItemBypalletIdState> {
  final RepositoryStockOpname? repository;
  ItemBypalletIdCubit({this.repository}) : super(ItemBypalletIdInitial());

  void getItemByPalletID(context, oid, locationId, paletId) async {
    emit(ItemBypalletIdLoading());
    repository!.getItembyPaletIDSO(context, oid, locationId, paletId).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("\n ITEM LIST : ${json}");
      if (statusCode == 401) {
        EasyLoading.showError("Authorisasi Habis, silahkan login kembali");
        Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
        emit(ItemBypalletIdFailed(statusCode: statusCode, json: json));
      } else if (statusCode == 400) {
        emit(ItemBypalletIdFailed(statusCode: statusCode, json: json));
      } else {
        emit(ItemBypalletIdLoaded(statusCode: statusCode, model: modelItembyPalletIdFromJson(jsonEncode(json))));
      }
    });
  }

  void scanPalletId(context, oid, locationId, pallet_id) async {
    emit(ItemBypalletIdLoading());
    print("$oid, $locationId, $pallet_id");
    // String? barcodeScanRes;
    // EasyLoading.show();
    // try {
    //   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
    //   print('Result Scan:  $barcodeScanRes');
      // if (barcodeScanRes != '-1') {
        repository!.getItembyPaletIDSO(context, oid, locationId, pallet_id).then((value) {
          print('PALLET: ${value.body}');
          print('PALLET: ${value.statusCode}');
          var statusCode = value.statusCode;
          EasyLoading.dismiss();
          if (value.statusCode == 200) {
            var json = jsonDecode(value.body);
            emit(ItemBypalletIdLoaded(statusCode: statusCode, model: modelItembyPalletIdFromJson(jsonEncode(json))));
          } else if (value.statusCode == 401) {
            EasyLoading.showError("Authorisasi Habis, silahkan login kembali");
            Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
          } else {
            var json = jsonDecode(value.body);
            emit(ItemBypalletIdFailed(statusCode: statusCode, json: json));
          }
        });
      // } else {
      //   EasyLoading.dismiss();
      // }
    // } on PlatformException {
    //   barcodeScanRes = 'Failed to get platform version.';
    // }
  }
}
