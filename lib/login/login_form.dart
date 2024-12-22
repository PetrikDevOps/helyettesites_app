import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helyettesites/app_theme.dart';
import 'package:helyettesites/user/user_type.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  UserType _userType = UserType.guest;

  Widget _buildStudent() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Név',
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Osztály',
          ),
        ),  
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 30), 
              Text('Kérlek válassz egy felhasználó típust:', style: AppTheme.mainThm.textTheme.bodyLarge),
              CupertinoSlidingSegmentedControl<UserType>(
                groupValue: _userType,
                children: <UserType, Widget>{
                  UserType.guest: Text('Vendég'),
                  UserType.student: Text('Diák'),
                  UserType.teacher: Text('Tanár'),
                },
                onValueChanged: (value) {
                  setState(() {
                    if (value != null) _userType = value;
                  });
                },
              ),
              if (_userType == UserType.student) _buildStudent(),
            ],
          ),
          CupertinoButton(
            onPressed: () {

          },
          child: const Text('Bejelentkezés'),
          ),
        ],
      );
  }
}
