import 'package:flutter/material.dart';

abstract interface class ITableAble {
  final DateTime date;

  //const
  ITableAble({
    required this.date,
  });

  Widget build(BuildContext context); 
} 
