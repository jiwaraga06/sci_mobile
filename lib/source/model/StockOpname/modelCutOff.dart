
import 'package:meta/meta.dart';
import 'dart:convert';

List<ModelCutOf> modelCutOfFromJson(String str) => List<ModelCutOf>.from(json.decode(str).map((x) => ModelCutOf.fromJson(x)));

String modelCutOfToJson(List<ModelCutOf> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelCutOf {
    final String? oid;
    final String? code;
    final String? date;
    final int? warehouseId;
    final String? warehouseCode;
    final String? warehouseName;

    ModelCutOf({
        required this.oid,
        required this.code,
        required this.date,
        required this.warehouseId,
        required this.warehouseCode,
        required this.warehouseName,
    });

    factory ModelCutOf.fromJson(Map<String, dynamic> json) => ModelCutOf(
        oid: json["oid"],
        code: json["code"],
        date: json["date"],
        warehouseId: json["warehouse_id"],
        warehouseCode: json["warehouse_code"],
        warehouseName: json["warehouse_name"],
    );

    Map<String, dynamic> toJson() => {
        "oid": oid,
        "code": code,
        "date": date,
        "warehouse_id": warehouseId,
        "warehouse_code": warehouseCode,
        "warehouse_name": warehouseName,
    };
}
