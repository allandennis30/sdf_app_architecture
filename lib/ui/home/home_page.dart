import 'package:flutter/material.dart';
import 'package:sdf_app_architecture/ui/auth/logout/viewmodels/widgets/logout_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
        child: Center(
      child: LogoutButton(),
    ));
  }
}
