import 'package:meta/meta.dart';
import 'dart:convert';

ModelPhysicalCount modelPhysicalCountFromJson(String str) => ModelPhysicalCount.fromJson(json.decode(str));

String modelPhysicalCountToJson(ModelPhysicalCount data) => json.encode(data.toJson());

class ModelPhysicalCount {
  final List<Datum> data;

  ModelPhysicalCount({
    required this.data,
  });

  factory ModelPhysicalCount.fromJson(Map<String, dynamic> json) => ModelPhysicalCount(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
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

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        palletId: json["pallet_id"],
        itemCode: json["item_code"],
        unitMeasureCode: json["unit_measure_code"],
        itemDescription1: json["item_description1"],
        itemDescription2: json["item_description2"],
        lotNo: json["lot_no"],
        qtyPackageSizeSystem: json["qty_package_size_system"] ?? 0,
        qtyPackagingPerPalletSystem: json["qty_packaging_per_pallet_system"] ?? 0,
        qtyStockSystem: json["qty_stock_system"] ?? 0,
        qtyPackageSizeCounted: json["qty_package_size_counted"] ?? 0,
        qtyPackagingPerPalletCounted: json["qty_packaging_per_pallet_counted"] ?? 0,
        qtyStockCounted: json["qty_stock_counted"] ?? 0,
        qtyStandardZak: json["qty_standard_zak"] ?? 0,
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
