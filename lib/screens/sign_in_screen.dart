import 'package:flutter/material.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/widgets/custom_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '';
  bool showPassword = true;
  bool isCheck = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 75),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Reset password',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 4,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'حقل البريد الالكتروني مطلوب';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    email = value;
                    print(value);
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 23,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Row(
                        children: [
                          // IconButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       showPassword = !showPassword;
                          //     });
                          //   },
                          //   icon: Icon(
                          //     showPassword
                          //         ? Icons.visibility_off
                          //         : Icons.visibility,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            showPassword ? 'Show' : 'Hide',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'كلمة السر مطلوبة';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    email = value;
                    print(value);
                  },
                  obscureText: showPassword,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white,
                        )),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 8,
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isCheck,
                      onChanged: (value) {
                        setState(() {
                          isCheck = value!;
                        });
                      },
                    ),
                    const Text(
                      'Rememeber me',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 59),
                CustomButton(
                  backgroundColor: Colors.black,
                  text: 'Sign in ',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, 'base_screen');
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //   builder: (context) => BaseScreen(),
                      // ));
                    }
                  },
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        height: 6,
                        color: AppColors.kGray,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'OR',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.kGray,
                        height: 6,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                CustomButton(
                  backgroundColor: Colors.black,
                  text: 'Create an account',
                  onTap: () {},
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 19,
                ),
                CustomButton(
                  text: 'Continue with Google',
                  onTap: () {},
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  image: 'assets/icons/google.png',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
