import 'package:flutter/material.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/user/user_provider.dart';

import 'package:helyettesites/utils/data/t_table_able.dart';

import 'package:helyettesites/utils/interfaces/i_table_able.dart';
import 'package:helyettesites/utils/model/m_news.dart';
import 'package:helyettesites/utils/model/m_room.dart';
import 'package:helyettesites/utils/model/m_sub.dart';
import 'package:provider/provider.dart';

class PTables extends ChangeNotifier {
  final RoomModel _roomModel = RoomModel();
  final SubModel _subModel = SubModel();
  final NewsModel _newsModel = NewsModel();

  bool _isLoading = false;
  List<List<List<ITableAble>>> _tables = [];

  get tables => _tables;
  get isLoading => _isLoading;

  List<List<List<ITableAble>>> _convertedTables(List<ITableAble> all) {
    List<DateTime> dates = all.map((e) => e.date).toSet().toList();
    List<List<List<ITableAble>>> grouped = [];

    for (var date in dates) {
      List<ITableAble> dateTables =
          all.where((element) => element.date == date).toList();

      List<TTableAble> types = dateTables.map((e) => e.type).toSet().toList();

      List<List<ITableAble>> typeGrouped = [];

      for (var type in types) {
        List<ITableAble> typeTables =
            dateTables.where((element) => element.type == type).toList();

        typeGrouped.add(typeTables);
      }

      grouped.add(typeGrouped);
    }

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

    return grouped;
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> init(BuildContext context) async {
    //setLoading(true);

    List<ITableAble> rooms = [];
    List<ITableAble> subs = [];
    List<ITableAble> news = [];

    User u = context.read<UserProvider>().user;
    try {
      subs = await _subModel.fetchSubs(u);
      rooms = await _roomModel.fetchRooms();
      news = await _newsModel.fetchNews();
    } catch (e) {
      rethrow;
    }

    List<ITableAble> all = [
      ...rooms,
      ...subs,
      ...news,
    ];

    _tables = _convertedTables(all);
    //setLoading(false);
  }
}
