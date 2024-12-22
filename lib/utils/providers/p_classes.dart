import 'package:flutter/material.dart';
import 'package:helyettesites/utils/models/drop_down_able.dart';

class PClasses extends ChangeNotifier {
  List<DropDownAble> _classes = [];
  List<DropDownAble> get classes => _classes;

  DropDownAble _selectedClass = DropDownAble(id: -1, name: 'Osztály');
  DropDownAble get selectedClass => _selectedClass;

  void setSelectedClass(DropDownAble selectedClass) {
    _selectedClass = selectedClass;
    notifyListeners();
  }
  void setClasses(List<DropDownAble> classes) {
    _classes = classes;
    _selectedClass = classes[0];
    notifyListeners();
  } 
}
