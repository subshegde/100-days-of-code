// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:sub100daysofcode/Widgets/loading.dart';
import 'package:sub100daysofcode/Widgets/myTextField.dart';
import 'package:sub100daysofcode/constants/appColors.dart';

class HomePageRive extends StatefulWidget {
  const HomePageRive({super.key});

  @override
  State<HomePageRive> createState() => _HomePageRiveState();
}

class _HomePageRiveState extends State<HomePageRive> {
  //* Text controlllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //* Rive Animation Path
  var animatePath = "assets/Rive/bear.riv";

  //* State Machine Input -> SMI Input bool to trigger actions
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  //* SMI Bool for eyes
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;

  //* SMI for numbers of chars in textfield
  SMIInput<double>? lookAtNumber;

  //* Art Board
  Artboard? artboard;

  //* State Machine Controller
  late StateMachineController? controller;

  //* toggle obscure text
  bool isObscureText = false;

  //*
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isLoading = false;

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  //* function to login
  loginFunction() async {
    //* unfocus the textfield
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();

    //* show loading screen
    setState(() {
      isLoading = true;
    });

    //* delay by 2s
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );

    if(mounted){
      setState(() {
        isLoading = false;
      });
    }

    //* check
    if (emailController.text == 'email' && passwordController.text == "email") {
      trigSuccess?.change(true);
    } else {
      trigFail?.change(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return LoadingOverlay(isLoading: isLoading, child: Scaffold(
      resizeToAvoidBottomInset: false,
      //* body
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),

            const Text(
              "Rive Demo",
              // style: GoogleFonts.poppins(
              //   fontSize: 25,
              //   fontWeight: FontWeight.bold,
              //   letterSpacing: 5,
              // ),
                style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),

            //todo rive animation
            SizedBox(
              height: screenHeight * 0.31,
              width: screenWidth * 0.9,
              child: RiveAnimation.asset(
                animatePath,
                fit: BoxFit.contain,
                stateMachines: const ["Login Machine"],
                onInit: (artboard) {
                  controller = StateMachineController.fromArtboard(
                    artboard,
                    "Login Machine",
                  );

                  if (controller == null) return;

                  artboard.addController(controller!);

                  isChecking = controller?.findInput("isChecking");
                  lookAtNumber = controller?.findInput("numLook");
                  isHandsUp = controller?.findInput("isHandsUp");
                  trigFail = controller?.findInput("trigFail");
                  trigSuccess = controller?.findInput("trigSuccess");
                },
              ),
            ),

            //todo login form
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              height: screenHeight * 0.339,
              decoration: BoxDecoration(
                color: AppColors.kScaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    MyTextField(
                      onChanged: (value) => lookAtNumber?.change(
                        value.length.toDouble(),
                      ),
                      focusNode: emailFocusNode,
                      controller: emailController,
                      labelText: "Email",
                      obscureText: false,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        iconSize: 20,
                        onPressed: () => emailController.clear(),
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    MyTextField(
                      focusNode: passwordFocusNode,
                      controller: passwordController,
                      labelText: "Password",
                      obscureText: isObscureText,
                      suffixIcon: IconButton(
                        icon: isObscureText
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //* login button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        elevation: 0,
                        shadowColor: Colors.white12,
                        minimumSize: Size(
                          screenWidth * 0.4,
                          screenHeight * 0.05,
                        ),
                      ),
                      onPressed: loginFunction,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    ));
  }
}
