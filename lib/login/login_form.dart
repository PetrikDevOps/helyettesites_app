import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helyettesites/user/user_helper.dart';
import 'package:helyettesites/user/user_provider.dart';
import 'package:helyettesites/utils/models/drop_down_able.dart';
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

    List<DropDownAble> toDisplay = _userType == UserType.student
        ? context.watch<PClasses>().classes
        : context.watch<PTeachers>().teachers;
    List<DropdownMenuEntry<DropDownAble>> dropdownMenuItems = toDisplay
        .map((DropDownAble dropDownAble) => DropdownMenuEntry<DropDownAble>(
              value: dropDownAble,
              label: dropDownAble.name,
            ))
        .toList();

    return DropdownMenu(
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
      children: [
        Text("Név: ",
            style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold)),
        SizedBox(width: width * 0.05),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Osztály: ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold)),
            SizedBox(width: width * 0.1),
            _buildDropDown(context)
          ],
        ),
        SizedBox(
          width: width * 0.7,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Név: ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: width * 0.53,
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
        SizedBox(height: height * 0.025),
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
          height: height * 0.4,
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
                        fontSize: width * 0.07,
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
              onPressed: () async {
                if (_userType == UserType.student) {
                  String oName = name.text;
                  int oClassId = Provider.of<PClasses>(context, listen: false)
                      .selectedClass
                      .id;
                  User s = User.student(name: oName, classId: oClassId);
                  Provider.of<UserProvider>(context, listen: false)
                      .setUser(s);
                  UserHelper.saveToStorage(s);
                } else if (_userType == UserType.teacher) {
                  String oName = Provider.of<PTeachers>(context, listen: false)
                      .selectedTeacher
                      .name;
                  int oTeacherId = Provider.of<PTeachers>(context, listen: false)
                      .selectedTeacher
                      .id;
                  User t = User.teacher(name: oName, teacherId: oTeacherId);
                  Provider.of<UserProvider>(context, listen: false)
                      .setUser(t);
                  await UserHelper.saveToStorage(t);
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

