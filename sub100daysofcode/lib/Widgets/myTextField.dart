import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    required this.suffixIcon,
    this.onTap,
    this.focusNode,
    this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String labelText;
  final bool obscureText;
  final IconButton suffixIcon;
  final Function()? onTap;
  final ValueChanged<String>? onChanged;
  //VoidCallback(String)? onChanged;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.09,
        child: TextField(
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          obscureText: widget.obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            hintText: widget.labelText,
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
            // hintStyle: GoogleFonts.poppins(
            //   color: Colors.grey[600],
            //   fontSize: 13,
            // ),
            filled: true,
            fillColor: AppColors.kWhiteColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.kBlackColor,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.kBlackColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.kRedColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
