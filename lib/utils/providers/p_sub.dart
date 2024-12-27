import 'package:flutter/material.dart';
import 'package:helyettesites/utils/models/table_able.dart';

class PSub extends ChangeNotifier{
  List<List<TableAble>> _subs = [];
  get subs => _subs;

  void setSubs(List<List<TableAble>> subs) {
    _subs = subs;
    notifyListeners();
  }

} 
