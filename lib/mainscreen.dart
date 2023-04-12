import 'package:bloc_auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_auth/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_auth/verify_phNo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign In with Phone"),
      ),
      body: SafeArea(
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TextField(
                    controller: phoneController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Phone Number",
                        counterText: ""
                    ),
                  ),

                  const SizedBox(height: 10,),

                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {

                      if(state is AuthCodeSentState) {
                        Navigator.push(context, CupertinoPageRoute(
                            builder: (context) => VerifyPhoneNumberScreen()
                        ));
                      }

                    },
                    builder: (context, state) {

                      if(state is AuthLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(
                          onPressed: () {
                            String phoneNumber = "+91" + phoneController.text;
                            BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                          },
                          color: Colors.blue,
                          child: const Text("Sign In"),
                        ),
                      );

                    },
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}