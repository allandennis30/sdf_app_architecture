import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:routefly/routefly.dart';
import 'package:sdf_app_architecture/config/dependencies.dart';
import 'package:sdf_app_architecture/domain/entities/dtos/credentials.dart';
import 'package:sdf_app_architecture/domain/validators/credentials_validator.dart';
import 'package:sdf_app_architecture/main.dart';
import 'package:sdf_app_architecture/ui/auth/login/viewModels/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final viewModel = injector.get<LoginViewmodel>();
  final validator = CredentialsValidator();
  final credentials = Credentials();

  @override
  void initState() {
    super.initState();
    viewModel.loginCommand.addListener(_listenable);
  }

  void _listenable() {
    if (viewModel.loginCommand.isSuccess) {
      Routefly.navigate(routePaths.home);
    } else if (viewModel.loginCommand.isFailure) {
      final error = viewModel.loginCommand.value as FailureCommand;

      final snackBar = SnackBar(
        content: Text(error.error.toString()),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const FlutterLogo(size: 100),
        const SizedBox(height: 20),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: credentials.setEmail,
          validator: validator.byField(credentials, 'email'),
          decoration: const InputDecoration(
              labelText: 'Email', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 20),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: credentials.setPassword,
          validator: validator.byField(credentials, 'password'),
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 40),
        ListenableBuilder(
          listenable: viewModel.loginCommand,
          builder: (context, _) {
            return ElevatedButton(
              onPressed: viewModel.loginCommand.isRunning
                  ? null
                  : () {
                      if (validator.validate(credentials).isValid) {
                        viewModel.loginCommand.execute(credentials);
                      }
                    },
              child: const Text('Login'),
            );
          },
        )
      ]),
    ));
  }
}
