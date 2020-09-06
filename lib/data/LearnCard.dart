import 'dart:ui';

import 'package:flutter/material.dart';

class LearnCard{
  final int position;
  final Color color;
  final String description;

  const LearnCard({
    this.position,
    this.color,
    this.description
  });

  factory LearnCard.fromJson(Map<String, dynamic> json) => LearnCard(
    position: json['position'] == null ? 1 : json['position'],
    color: Colors.blue,
    description: json['description'] == null ? '' : json['description']
  );

}