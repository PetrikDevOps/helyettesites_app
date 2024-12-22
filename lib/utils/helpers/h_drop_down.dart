import 'package:flutter/cupertino.dart';
import 'package:helyettesites/utils/models/drop_down_able.dart';
import 'package:helyettesites/utils/providers/p_classes.dart';
import 'package:helyettesites/utils/providers/p_teachers.dart';
import 'package:provider/provider.dart';

class HDropDown {
  static Future<bool> getTeachers(BuildContext context) async {
    List<DropDownAble> teachers = [
      DropDownAble(
        id: 1,
        name: 'Kovács János',
      ),
      DropDownAble(
        id: 2,
        name: 'Nagy Béla',
      ),
      DropDownAble(
        id: 3,
        name: 'Kiss Pista',
      ),
    ];

    try {
      context.read<PTeachers>().setTeachers(
        await Future.delayed(Duration(seconds: 2), () => teachers)
      );
      return true;
    } catch (e) {
      return false;
    }
  }


  static Future<bool> getClasses(BuildContext context) async {
    List<DropDownAble> classes = [
      DropDownAble(
        id: 1,
        name: '9/A',
      ),
      DropDownAble(
        id: 2,
        name: '9/B',
      ),
      DropDownAble(
        id: 3,
        name: '15/C/2',
      ),
    ];

    try {
      context.read<PClasses>().setClasses(
        await Future.delayed(Duration(seconds: 2), () => classes)
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

