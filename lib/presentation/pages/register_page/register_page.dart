import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reTypePasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          ref.read(routerProvider).goNamed('main');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );

    return Scaffold(
        body: ListView(
      children: [
        Column(
          children: [
            verticalSpace(50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Create Your Account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25, color: blue),
                ),
              ),
            ),
            verticalSpace(24),
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.add_a_photo,
                size: 50.0,
                color: grey,
              ),
            ),
            verticalSpace(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  FlixTextField(
                    labelText: 'Email',
                    controller: emailController,
                    hintText: 'Example: name@gmail.com',
                  ),
                  verticalSpace(24),
                  FlixTextField(
                    labelText: 'Name',
                    controller: nameController,
                    hintText: 'Type your name',
                  ),
                  verticalSpace(24),
                  FlixTextField(
                      labelText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                      hintText: 'Type your password'),
                  verticalSpace(24),
                  FlixTextField(
                    labelText: 'Confirmation Password',
                    controller: reTypePasswordController,
                    obscureText: true,
                    hintText: 'Retype your password',
                  ),
                  verticalSpace(24),
                  switch (ref.watch(userDataProvider)) {
                    AsyncData(:final value) => value == null
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: blue),
                              onPressed: () {
                                if (passwordController.text ==
                                    reTypePasswordController.text) {
                                  ref.read(userDataProvider.notifier).register(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text);
                                } else {
                                  context.showSnackBar(
                                      'Your confirmation password is not the same');
                                }
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: backgroundColor),
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                    _ => const Center(
                        child: CircularProgressIndicator(),
                      )
                  },
                  verticalSpace(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            ref.read(routerProvider).goNamed('login');
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: blue),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}
