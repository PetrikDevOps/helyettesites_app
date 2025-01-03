import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:helyettesites/utils/constans/urls.dart';
import 'package:helyettesites/utils/data/rooms.dart';

class RoomModel {
  Dio dio = Dio();
 Future<List<Room>> fetchRooms() async {
    List<Room> rooms = [];
    var res = await dio.get(Urls.baseUrl + Urls.rooms);
    
    if (res.statusCode != 200) {
      return rooms;
    }
    if (res.data["status"] != "success") {
      return rooms;
    }
    rooms = (res.data["data"] as List).map((e) => Room.fromJson(e)).toList();
    print(rooms);
    return rooms;
 }  
}
