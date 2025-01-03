import 'package:flutter/material.dart';
import 'package:helyettesites/utils/interfaces/i_table_able.dart';
import 'package:helyettesites/utils/model/m_room.dart';

class PTables extends ChangeNotifier{
  final RoomModel _roomModel = RoomModel();
  List<List<List<ITableAble>>> _tables = [];
  get tables => _tables;

  Future<void> init() async {
    List<ITableAble> rooms = [];
    List<ITableAble> subs = [];
    List<ITableAble> news = [];

    try {
      rooms = await _roomModel.fetchRooms();
    } catch (e) {
      print(e);
    }

    _tables = [
      [rooms],
      [subs],
      [news]
    ];
    notifyListeners();
  }

  void setSubs(List<List<List<ITableAble>>> tables) {
    _tables = tables;
    notifyListeners();
  }

  void addTable(List<List<ITableAble>> table) {
    _tables.add(table);
    notifyListeners();
  } 

} 
