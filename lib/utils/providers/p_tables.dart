import 'package:flutter/material.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:helyettesites/utils/data/table_able.dart';
import 'package:helyettesites/utils/interfaces/i_table_able.dart';
import 'package:helyettesites/utils/model/m_news.dart';
import 'package:helyettesites/utils/model/m_room.dart';
import 'package:helyettesites/utils/model/m_sub.dart';
import 'package:provider/provider.dart';

class PTables extends ChangeNotifier{
  final RoomModel _roomModel = RoomModel();
  final SubModel _subModel = SubModel();
  final NewsModel _newsModel = NewsModel();
  List<List<List<ITableAble>>> _tables = [];
  get tables => _tables;

  List<List<List<ITableAble>>> _convertedTables(List<ITableAble>? rooms, List<ITableAble>? subs, List<ITableAble>? news) {
    //[
    //  //date
    //  [
    //    [
    //    // type
    //      [
    //        //name
    //        Room1
    //        Room1
    //        Room1
    //      ]
    //      [
    //        Room2
    //      ]
    //    ]
    //    [
    //      [
    //       news
    //       news
    //      ]
    //    ]
    //    [
    //      [
    //        Teacher1
    //        Teacher1
    //     ]
    //      [
    //        Teacher2
    //        Teacher2
    //      ]
    //    ]
    //  ]
    //
    //  //dec 20
    //  [
    //   [
    //   Teacher1
    //   Teacher1
    //   ]
    //   [
    //   Teacher2
    //   Teacher2
    //   ]
    //  ]

    //]

    return [];
  }

  Future<void> init(BuildContext context) async {
    List<ITableAble> rooms = [];
    List<ITableAble> subs = [];
    List<ITableAble> news = [];

    User u = context.read<UserProvider>().user;

    try {
      subs = await _subModel.fetchSubs(u);
      rooms = await _roomModel.fetchRooms();
      news = await _newsModel.fetchNews();
    } catch (e) {
      print(e);
    }

    _tables = [
      [rooms],
      [subs],
      [news]
    ];

    print(_tables);
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
