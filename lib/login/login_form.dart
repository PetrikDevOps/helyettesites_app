import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:helyettesites/utils/data/drop_down_able.dart';
import 'package:helyettesites/utils/providers/p_classes.dart';
import 'package:helyettesites/utils/providers/p_teachers.dart';
import 'package:provider/provider.dart';
import 'package:helyettesites/user/user.dart';
import 'package:helyettesites/user/user_type.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  UserType _userType = UserType.student;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = context.watch<UserProvider>().user;
    if (user.userType != UserType.none) {
      // Post-frame callback to avoid navigation issues
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/substitute');
      });
    }
  }

  Widget _buildDropDown(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String actualId = _userType == UserType.student
        ? context.watch<PClasses>().selectedClass.id
        : context.watch<PTeachers>().selectedTeacher.id;

    List<DropDownAble> toDisplay = _userType == UserType.student
        ? context.watch<PClasses>().classes
        : context.watch<PTeachers>().teachers;
    List<DropdownMenuEntry<DropDownAble>> dropdownMenuItems = toDisplay.asMap().entries
        .map((entry) => DropdownMenuEntry<DropDownAble>(
              value: entry.value,
              label: entry.value.name,              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(color: Colors.white, fontSize: width * 0.04)),
                backgroundColor: entry.value.id == actualId ? MaterialStateProperty.all<Color>(Color(0xFF25544B)) : entry.key % 2 == 0 ? MaterialStateProperty.all<Color>(Color(0x00000000)) : MaterialStateProperty.all<Color>(Color(0x10000000)),
                foregroundColor: entry.value.id == actualId ? MaterialStateProperty.all<Color>(Color(0xFFFAFAF9)) : MaterialStateProperty.all<Color>(Color(0xFF25544B)),
              
              ),
            ))
        .toList();

    return DropdownMenu(
      menuStyle: MenuStyle( 
        maximumSize: MaterialStateProperty.all<Size>(Size(width * 0.7, height * 0.5)), 
      ),
      initialSelection: _userType == UserType.student
          ? context.watch<PClasses>().selectedClass
          : context.watch<PTeachers>().selectedTeacher,
      textStyle: TextStyle(color: Colors.white, fontSize: width * 0.05),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      enableFilter: true,
      enableSearch: true,
      dropdownMenuEntries: dropdownMenuItems,
      onSelected: (DropDownAble? value) {
        if (value != null) {
          if (_userType == UserType.student) {
            context.read<PClasses>().setSelectedClass(value);
          } else {
            context.read<PTeachers>().setSelectedTeacher(value);
          }
        }
      },
    );
  }

  Widget _buildTeacher(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Név: ",
            style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold)),
        _buildDropDown(context), 
      ],
    );
  }

  Widget _buildStudent(BuildContext context, TextEditingController name) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: height * 0.025),
        SizedBox(
          width: width * 0.7,
          child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Osztály: ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold)), 
            _buildDropDown(context)
          ],
        ),
        ),
        SizedBox(
          width: width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Név: ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: width * 0.45,
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                  controller: name,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController name = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width * 0.8,
          child: Container(
            margin: EdgeInsets.only(top: height * 0.04),
            decoration: BoxDecoration(
              color: Color(0x2FFAFAF9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.03),
                  Text(
                    'Kérlek válassz egy felhasználó típust:',
                    style: TextStyle(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFAFAF9)),
                  ),
                  SizedBox(height: height * 0.02),
                  CupertinoSlidingSegmentedControl<UserType>(
                    backgroundColor: Color(0x4FFAFAF9),
                    groupValue: _userType,
                    children: <UserType, Widget>{
                      UserType.student: Text('Diák',
                          style: TextStyle(
                              fontSize: width * 0.05,
                              color: Color(0xFF25544B))),
                      UserType.teacher: Text('Tanár',
                          style: TextStyle(
                              fontSize: width * 0.05,
                              color: Color(0xFF25544B))),
                      UserType.guest: Text('Vendég',
                          style: TextStyle(
                              fontSize: width * 0.05,
                              color: Color(0xFF25544B))),
                    },
                    onValueChanged: (value) {
                      setState(() {
                        if (value != null) _userType = value;
                      });
                    },
                  ),
                  if (_userType == UserType.student)
                    _buildStudent(context, name),
                  if (_userType == UserType.teacher) _buildTeacher(context),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF25544B)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFFAFAF9)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                  ),
                ),
              ),
              onPressed: () {
                if (_userType == UserType.student) {
                  String oName = name.text;
                  String oClassId = Provider.of<PClasses>(context, listen: false)
                      .selectedClass
                      .id;
                  User s = User.student(name: oName, classId: oClassId);
                  Provider.of<UserProvider>(context, listen: false)
                      .setUser(s);
                  } else if (_userType == UserType.teacher) {
                  String oName = Provider.of<PTeachers>(context, listen: false)
                      .selectedTeacher
                      .name;
                  String oTeacherId = Provider.of<PTeachers>(context, listen: false)
                      .selectedTeacher
                      .id;
                  User t = User.teacher(name: oName, teacherId: oTeacherId);
                  Provider.of<UserProvider>(context, listen: false)
                      .setUser(t);
                } else {
                  User g = User.guest();
                  Provider.of<UserProvider>(context, listen: false)
                      .setUser(g);
                }
                context.go('/substitute');
              },
              child: Text('Belépés', style: TextStyle(fontSize: width * 0.05)),
            ),
            SizedBox(height: height * 0.05),
          ],
        ),
      ],
    );
  }
}

