import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveDemoLogin extends StatefulWidget {
  const RiveDemoLogin({super.key});

  @override
  State<RiveDemoLogin> createState() => _RiveDemoLoginState();
}

class _RiveDemoLoginState extends State<RiveDemoLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var riveUrl = 'assets/animations/riveAnimations.riv';

  SMITrigger? failTrigger, successTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? lookNumber;
  StateMachineController? stateMachineController;
  Artboard? artboard;

  @override
  void initState() {
    super.initState();

    rootBundle.load(riveUrl).then((value) {
      final file = RiveFile.import(value);
      final art = file.mainArtboard;
      stateMachineController =
          StateMachineController.fromArtboard(art, 'Loading Machine');
      
      if (stateMachineController != null) {
        art.addController(stateMachineController!);
        stateMachineController!.inputs.forEach((element) {
          if (element.name == 'isChecking') {
            isChecking = element as SMIBool;
          } else if (element.name == 'isHandsUp') {
            isHandsUp = element as SMIBool;
          } else if (element.name == 'trigSuccess') {
            successTrigger = element as SMITrigger;
          } else if (element.name == 'trigFail') {
            failTrigger = element as SMITrigger;
          } else if (element.name == 'numLook') {
            lookNumber = element as SMINumber;
          }
        });
      }

      setState(() {
        artboard = art;
      });
    });
  }

  void lookAround() {
    isChecking?.change(true);
    isHandsUp?.change(true);
    lookNumber?.change(0);
  }

  void moveEyes(String value) {
    lookNumber?.change(value.length.toDouble());
  }

  void handUpOnEyes() {
    isHandsUp?.change(true);
    isChecking?.change(false);
  }

  void loginClick() {
    isChecking?.change(false);
    isHandsUp?.change(false);

    // Check if login credentials are correct
    if (emailController.text == 'email' && passwordController.text == 'password') {
      successTrigger?.fire();
    } else {
      failTrigger?.fire();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background
      appBar: AppBar(
        title: const Text("Login Page"),
        backgroundColor: Colors.black87, // Slightly darker black for the app bar
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey, // Attach form key for validation
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or title section (optional)
                  const SizedBox(height: 40),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Display the Rive animation
                  if (artboard != null)
                    SizedBox(
                      height: 300,
                      width: 500,
                      child: Rive(artboard: artboard!),
                    ),

                  // Email TextFormField
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 350,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black45, // Dark grey for input fields
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey), // Grey border
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          moveEyes(value);
                        },
                        onTap: () {
                          lookAround();
                        },
                        controller: emailController,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "Enter your email",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          String pattern =
                              r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,4}$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  // Password TextFormField
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 350,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black45, // Dark grey for input fields
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey), // Grey border
                      ),
                      child: TextFormField(
                        onTap: handUpOnEyes,
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "Enter your password",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  // Forgot Password Link (optional)
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Login Button
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        loginClick();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Grey background for button
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          color: Colors.white, // White text color
                          fontSize: 18,
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
