// To parse this JSON data, do
//
//     final modelLocationCodeSoList = modelLocationCodeSoListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ModelLocationCodeSoList> modelLocationCodeSoListFromJson(String str) => List<ModelLocationCodeSoList>.from(json.decode(str).map((x) => ModelLocationCodeSoList.fromJson(x)));

String modelLocationCodeSoListToJson(List<ModelLocationCodeSoList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelLocationCodeSoList {
    final int? id;
    final String? code;
    final String? name;
    final bool? isActive;

    ModelLocationCodeSoList({
        required this.id,
        required this.code,
        required this.name,
        required this.isActive,
    });

    factory ModelLocationCodeSoList.fromJson(Map<String, dynamic> json) => ModelLocationCodeSoList(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "is_active": isActive,
    };
}
