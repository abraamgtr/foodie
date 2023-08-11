import 'package:flutter/material.dart';

class FruitsRepo {
  String? name;
  String? imgae;
  Color? color;

  FruitsRepo({this.name, this.imgae, this.color});

  factory FruitsRepo.fromJson(Map<String, dynamic>? json) =>
      FruitsRepo(name: json?["name"] ?? "", imgae: json?["image"],
      color: json?["color"]);
}
