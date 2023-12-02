import 'package:flix_id/data/dummies/dummy_authentication.dart';
import 'package:flix_id/data/dummies/dummy_user_repository.dart';
import 'package:flix_id/domain/usescases/login/login.dart';
import 'package:flix_id/presentation/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Center(
            child: ElevatedButton(
          onPressed: () {
            Login login = Login(
                authentication: DummyAuthentication(),
                userRepository: DummyUserRepository());

            login
                .call(LoginParams(email: "email", password: "password"))
                .then((result) => {
                      if (result.isSucces)
                        {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MainPage(user: result.resultValue!)))
                        }
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result.errorMassage!)))
                        }
                    });
          },
          child: const Text("Login"),
        )));
  }
}
