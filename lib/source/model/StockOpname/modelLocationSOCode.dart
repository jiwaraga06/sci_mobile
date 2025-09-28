// To parse this JSON data, do
//
//     final modelLocationCodeSo = modelLocationCodeSoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelLocationCodeSo modelLocationCodeSoFromJson(String str) => ModelLocationCodeSo.fromJson(json.decode(str));

String modelLocationCodeSoToJson(ModelLocationCodeSo data) => json.encode(data.toJson());

class ModelLocationCodeSo {
    final int? id;
    final String? code;
    final String? name;
    final bool? isActive;

    ModelLocationCodeSo({
        required this.id,
        required this.code,
        required this.name,
        required this.isActive,
    });

    factory ModelLocationCodeSo.fromJson(Map<String, dynamic> json) => ModelLocationCodeSo(
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
