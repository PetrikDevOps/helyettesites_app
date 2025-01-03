class DropDownAble {
  final String name;
  final String id;
  final String? long;

  DropDownAble({required this.name, required this.id , this.long});
  
  factory DropDownAble.fromJson(Map<String, dynamic> json) {
    if (json['classId'] != null) {
      return DropDownAble(name: json['name'], id: json['classId']);
    } 
    if (json['short'] != null) {
      if (json['name'].toString().startsWith('[')) {
        return DropDownAble(name: "Oktató", id: json['id'], long: json['name']);
      }
      return DropDownAble(name: json['short'], id: json['id'], long: json['name']);
    }
    return DropDownAble(name: json['name'], id: json['id']);
  }
}
