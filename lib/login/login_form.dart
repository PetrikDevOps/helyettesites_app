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
  
  Widget _buildDropDown(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    List<DropDownAble> toDisplay = _userType == UserType.student ? context.watch<PClasses>().classes : context.watch<PTeachers>().teachers;
    List<DropdownMenuEntry<DropDownAble>> dropdownMenuItems = toDisplay.map((DropDownAble dropDownAble) {
      return DropdownMenuEntry<DropDownAble>(
        value: dropDownAble,
        label: dropDownAble.name,
      );
    }).toList();


    return DropdownMenu(
      initialSelection: _userType == UserType.student ? context.watch<PClasses>().selectedClass : context.watch<PTeachers>().selectedTeacher,
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
        Text("Név: ", style: TextStyle(color: Colors.white, fontSize: width * 0.05)),
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
        TextField(
          controller: name,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            labelText: 'Név',
            labelStyle: TextStyle(color: Colors.white, fontSize: width * 0.05),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusColor: Colors.white,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: height * 0.025),
        Row(
          children: [
            Text("Osztály: ", style: TextStyle(color: Colors.white, fontSize: width * 0.05)),
            SizedBox(width: width * 0.05),
            _buildDropDown(context)
          ],
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
            height: height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03), 
                Text('Kérlek válassz egy felhasználó típust:', style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold, color: Color(0xFFFAFAF9))),
                SizedBox(height: height * 0.02),
                CupertinoSlidingSegmentedControl<UserType>(
                  backgroundColor: Color(0x4FFAFAF9),
                  groupValue: _userType,
                  children: <UserType, Widget>{   
                    UserType.student: Text('Diák', style: TextStyle(fontSize: width * 0.05)),
                    UserType.teacher: Text('Tanár', style: TextStyle(fontSize: width * 0.05)),
                    UserType.guest: Text('Vendég', style: TextStyle(fontSize: width * 0.05)),      
                  },
                  onValueChanged: (value) {
                    setState(() {
                      if (value != null) _userType = value;
                    });
                  },
                ),
                if (_userType == UserType.student) _buildStudent(context, name),
                if (_userType == UserType.teacher) _buildTeacher(context),
              ],
            ),
          ),
          Column(
            children: [
              ElevatedButton(
               onPressed: () async{ 
                if (_userType == UserType.student) {
                  String oName = name.text;
                  int oClassId = Provider.of<PClasses>(context, listen: false).selectedClass.id;
                  User s = User.student(name: oName, classId: oClassId);
                  Provider.of<UserProvider>(context, listen: false).setUser(s);
                  UserHelper.saveToStorage(s);
                } else if (_userType == UserType.teacher) {
                  String oName = Provider.of<PTeachers>(context, listen: false).selectedTeacher.name;
                  int oTeacherId = Provider.of<PTeachers>(context, listen: false).selectedTeacher.id;
                  User t = User.teacher(name: oName, teacherId: oTeacherId);
                  Provider.of<UserProvider>(context, listen: false).setUser(t);
                  await UserHelper.saveToStorage(t);
                  print('teacher'); 
                  print(await UserHelper.isUserInLs());
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
