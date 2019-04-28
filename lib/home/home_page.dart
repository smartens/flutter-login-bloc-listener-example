import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_login/authentication/authentication.dart';
import 'package:flutter_login/login/login_page.dart';
import 'package:user_repository/user_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return BlocListener(
        bloc: authenticationBloc,
        listener: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUnauthenticated) {
            print("AppState AuthenticationUnauthenticated Listener");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(
                        userRepository: authenticationBloc.userRepository)),
                (_) => false);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: Container(
            child: Center(
                child: RaisedButton(
              child: Text('logout'),
              onPressed: () {
                authenticationBloc.dispatch(LoggedOut());
              },
            )),
          ),
        ));
  }
}
