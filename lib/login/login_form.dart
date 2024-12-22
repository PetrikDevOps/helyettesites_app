import 'package:flutter/material.dart';
import 'package:helyettesites/user/user_type.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  UserType _userType = UserType.guest;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Válassz felhasználó típust $_userType', style: TextStyle(fontSize: 20)),
          Text('Kérlek válassz egy felhasználó típust:'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _userType = UserType.student;
                  });
                },
                child: const Text('Diák'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _userType = UserType.teacher;
                  });
                },
                child: const Text('Tanár'),
              ),
            ],
          ),
        ],
      );
  }
}
