import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';

class LoginPageDay17 extends StatefulWidget {
  const LoginPageDay17({super.key});

  @override
  State<LoginPageDay17> createState() => _LoginPage17State();
}

class _LoginPage17State extends State<LoginPageDay17> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return SafeArea(child: 
    Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/day17/bg_black.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.multiply),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    ));
  }


  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome",
          style: TextStyle(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Please login with your information"),
        const SizedBox(height: 40),
        _buildGreyText("Email address"),
        _buildEmailField(emailController),
        const SizedBox(height: 10),
        _buildGreyText("Password"),
        _buildPasswordField(passwordController),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildEmailField(TextEditingController controller,) {
    return TextFormField(
              controller: controller,
              autofocus: false,
              textCapitalization: TextCapitalization.none,
              cursorColor: AppColors.black,
              obscureText: false,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/day17/id.png',
                    width: 24,
                    height: 24,
                    color: AppColors.black,
                  ),
                ),
                hintText: 'Email / Employee ID',
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.black,
                    width: .5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.black,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: AppColors.black,
                                      width: .5,
                                    ),
                                  ),
                filled: true,
                fillColor: AppColors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email/Employee ID should not be empty';
                }
                return null;
              },
            );
  }

  
  Widget _buildPasswordField(TextEditingController controller,) {
    return TextFormField(
                                controller: controller,
                                autofocus: false,
                                obscureText: !_isPasswordVisible,
                                cursorColor: AppColors.black,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'assets/day17/pass.png',
                                      width: 24,
                                      height: 24,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  hintText: 'Password',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: AppColors.black,
                                      width: .5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: AppColors.black,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: AppColors.black,
                                      width: .5,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter password';
                                  }
                                  return null;
                                },
                                // onChanged: (String pass) {
                                //   setState(() {
                                //     _passwordController.text = pass;
                                //   });
                                //   // formKey.currentState!.validate();
                                // },
                              );
  }
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.black,
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: AppColors.grey,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("LOGIN",style: TextStyle(color: AppColors.white),),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Login with"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/day17/facebook.png",height: 40,width: 40,)),
              Tab(icon: Image.asset("assets/day17/twitter.png",height: 40,width: 40,)),
              Tab(icon: Image.asset("assets/day17/github.png",height: 40,width: 40,)),
            ],
          )
        ],
      ),
    );
  }
}
