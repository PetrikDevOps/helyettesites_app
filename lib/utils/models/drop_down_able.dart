class DropDownAble {
  final String name;
  final String id;

  DropDownAble({required this.name, required this.id});
  
  factory DropDownAble.fromJson(Map<String, dynamic> json) {
    if (json['classId'] != null) {
      return DropDownAble(name: json['name'], id: json['classId']);
    } 
    if (json['short'] != null) {
      return DropDownAble(name: json['short'], id: json['id']);
    }
    return DropDownAble(name: json['name'], id: json['id']);
  }
}
