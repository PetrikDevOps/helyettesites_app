import 'package:flutter/material.dart';
import 'package:helyettesites/utils/data/t_table_able.dart';

abstract interface class ITableAble {
  final DateTime date;
  final String id;
  final TTableAble type;

  //const
  ITableAble({
    required this.date,
    required this.id,
    required this.type,
  });

  Widget build(BuildContext context); 
} 
