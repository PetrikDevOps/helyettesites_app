import 'package:flutter/material.dart';
import 'package:helyettesites/utils/data/drop_down_able.dart';

class PTeachers extends ChangeNotifier {
  List<DropDownAble> _teachers = [];
  List<DropDownAble> get teachers => _teachers;
  
  DropDownAble _selectedTeacher = DropDownAble(id: "", name: 'Tanár');
  DropDownAble get selectedTeacher => _selectedTeacher;

  void setSelectedTeacher(DropDownAble selectedTeacher) {
    _selectedTeacher = selectedTeacher;
    notifyListeners();
  }

  void setTeachers(List<DropDownAble> teachers) {
    _teachers = teachers;
    _selectedTeacher = teachers[0];
    notifyListeners();
  }
}
