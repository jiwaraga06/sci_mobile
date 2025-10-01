// To parse this JSON data, do
//
//     final modelPhysicalCount = modelPhysicalCountFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelPhysicalCount modelPhysicalCountFromJson(String str) => ModelPhysicalCount.fromJson(json.decode(str));

String modelPhysicalCountToJson(ModelPhysicalCount data) => json.encode(data.toJson());

class ModelPhysicalCount {
    final List<Datum> data;
    final Summary summary;

    ModelPhysicalCount({
        required this.data,
        required this.summary,
    });

    factory ModelPhysicalCount.fromJson(Map<String, dynamic> json) => ModelPhysicalCount(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        summary: Summary.fromJson(json["summary"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "summary": summary.toJson(),
    };
}

class Datum {
    final String palletId;
    final String itemCode;
    final String unitMeasureCode;
    final String itemDescription1;
    final String itemDescription2;
    final String lotNo;
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

class Summary {
    final Entry entry;

    Summary({
        required this.entry,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        entry: Entry.fromJson(json["entry"]),
    );

    Map<String, dynamic> toJson() => {
        "entry": entry.toJson(),
    };
}

class Entry {
    final num? palletCount;
    final num? totalQtyStockCounted;

    Entry({
        required this.palletCount,
        required this.totalQtyStockCounted,
    });

    factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        palletCount: json["pallet_count"],
        totalQtyStockCounted: json["total_qty_stock_counted"],
    );

    Map<String, dynamic> toJson() => {
        "pallet_count": palletCount,
        "total_qty_stock_counted": totalQtyStockCounted,
    };
}
