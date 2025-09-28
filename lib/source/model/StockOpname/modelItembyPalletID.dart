// To parse this JSON data, do
//
//     final modelItembyPalletId = modelItembyPalletIdFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelItembyPalletId modelItembyPalletIdFromJson(String str) => ModelItembyPalletId.fromJson(json.decode(str));

String modelItembyPalletIdToJson(ModelItembyPalletId data) => json.encode(data.toJson());

class ModelItembyPalletId {
  final String? message;
  final Data data;

  ModelItembyPalletId({
    required this.message,
    required this.data,
  });

  factory ModelItembyPalletId.fromJson(Map<String, dynamic> json) => ModelItembyPalletId(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final String? palletId;
  final String? itemCode;
  final String? unitMeasureCode;
  final String? itemDescription1;
  final String? itemDescription2;
  final String? lotNo;
  final num? qtyPackageSizeSystem;
  final num? qtyPackagingPerPalletSystem;
  final num? qtyStockSystem;
  final num? qtyPackageSizeCounted;
  final num? qtyPackagingPerPalletCounted;
  final num? qtyStockCounted;
  final num? qtyStandardZak;

  Data({
    required this.palletId,
    required this.itemCode,
    required this.unitMeasureCode,
    required this.itemDescription1,
    required this.itemDescription2,
    required this.lotNo,
    required this.qtyPackageSizeSystem,
    required this.qtyPackagingPerPalletSystem,
    required this.qtyStockSystem,
    required this.qtyPackageSizeCounted,
    required this.qtyPackagingPerPalletCounted,
    required this.qtyStockCounted,
    required this.qtyStandardZak,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        palletId: json["pallet_id"],
        itemCode: json["item_code"],
        unitMeasureCode: json["unit_measure_code"],
        itemDescription1: json["item_description1"],
        itemDescription2: json["item_description2"],
        lotNo: json["lot_no"],
        qtyPackageSizeSystem: json["qty_package_size_system"],
        qtyPackagingPerPalletSystem: json["qty_packaging_per_pallet_system"],
        qtyStockSystem: json["qty_stock_system"],
        qtyPackageSizeCounted: json["qty_package_size_counted"],
        qtyPackagingPerPalletCounted: json["qty_packaging_per_pallet_counted"],
        qtyStockCounted: json["qty_stock_counted"],
        qtyStandardZak: json["qty_standard_zak"],
      );

  Map<String, dynamic> toJson() => {
        "pallet_id": palletId,
        "item_code": itemCode,
        "unit_measure_code": unitMeasureCode,
        "item_description1": itemDescription1,
        "item_description2": itemDescription2,
        "lot_no": lotNo,
        "qty_package_size_system": qtyPackageSizeSystem,
        "qty_packaging_per_pallet_system": qtyPackagingPerPalletSystem,
        "qty_stock_system": qtyStockSystem,
        "qty_package_size_counted": qtyPackageSizeCounted,
        "qty_packaging_per_pallet_counted": qtyPackagingPerPalletCounted,
        "qty_stock_counted": qtyStockCounted,
        "qty_standard_zak": qtyStandardZak,
      };
}
