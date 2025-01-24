import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';

class LoginPageSnippingBottom extends StatefulWidget {
  final bool reverse;
  LoginPageSnippingBottom({Key? key, this.reverse = false}) : super(key: key);

  @override
  _LoginPageSnippingBottomState createState() => _LoginPageSnippingBottomState();
}

class _LoginPageSnippingBottomState extends State<LoginPageSnippingBottom> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool _isPasswordVisible = false;
  late Size mediaSize;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(bottom: 0, child: _buildBottom()),
      ],
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      height: 635,
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
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
        const SizedBox(height: 80,),
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

  Widget _buildEmailField(TextEditingController controller) {
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
            'assets/day18/id.png',
            width: 24,
            height: 24,
            color: AppColors.black,
          ),
        ),
        hintText: 'Email',
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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

  Widget _buildPasswordField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      obscureText: !_isPasswordVisible,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/day18/pass.png',
            width: 24,
            height: 24,
            color: AppColors.black,
          ),
        ),
        hintText: 'Password',
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
      child: const Text(
        "LOGIN",
        style: TextStyle(color: AppColors.white),
      ),
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
              Tab(icon: Image.asset("assets/day18/facebook.png", height: 40, width: 40)),
              Tab(icon: Image.asset("assets/day18/twitter.png", height: 40, width: 40)),
              Tab(icon: Image.asset("assets/day18/github.png", height: 40, width: 40)),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
