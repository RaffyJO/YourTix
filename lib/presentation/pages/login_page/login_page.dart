import 'package:flix_id/domain/usescases/login/login.dart';
import 'package:flix_id/presentation/pages/main_page/main_page.dart';
import 'package:flix_id/presentation/providers/usecases/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Center(
            child: ElevatedButton(
          onPressed: () {
            Login login = ref.watch(loginProvider);

            login
                .call(LoginParams(email: "raffy@gmail.com", password: "123456"))
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
