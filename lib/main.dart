import 'package:bloc_auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_auth/homeScreen.dart';
import 'package:bloc_auth/mainscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'cubits/auth_cubit/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (oldState, newState) {
            return oldState is AuthInitialState;
          },
          builder: (context, state) {
            if(state is AuthLoggedInState) {
              return HomeScreen();
            }
            else if(state is AuthLoggedOutState) {
              return SignInScreen();
            }
            else {
              return Scaffold();
            }
          },
        ),
      ),
    );
  }
}