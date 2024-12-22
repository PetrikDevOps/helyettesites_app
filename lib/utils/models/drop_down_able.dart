class DropDownAble {
  final String name;
  final int id;

  DropDownAble({required this.name, required this.id});
  
  factory DropDownAble.fromJson(Map<String, dynamic> json) {
    if (json['classId'] != null) {
      return DropDownAble(name: json['name'], id: json['classId']);
    } 
    if (json['teacherId'] != null) {
      return DropDownAble(name: json['name'], id: json['teacherId']);
    }
    return DropDownAble(name: json['name'], id: json['id']);
  }
}
