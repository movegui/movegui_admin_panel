import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/screens/dashboard_screen.dart';
import 'package:movegui_admin_panel/screens/main_screen.dart';
import 'package:movegui_admin_panel/services/my_app_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureTextForm = true;
  int index = 0;
  final GlobalKey<FormState> _formkey = GlobalKey();
  List<UserModel>? users;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
   bool obscureText = true;
    bool isloading = false;
  FirebaseAuth? auth;
  fetchUsers() {
    var userBox = Hive.box<UserModel>('user_box');
    users = userBox.values.toList();
  }

  @override
  void initState() {
   // fetchUsers();
     _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

    @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      // Focus Nodes
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

    Future<void> _loginFct() async {
     final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    
    if(isValid){
      try{
        setState(() {
          isloading = true;
        });
       await auth?.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
       Fluttertoast.showToast(
        msg: "User is logged !!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) => MainScreen(pageScreen: DashboardScreen(),)));
      }catch(error){
        MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.toString(),
          fct: (){});
      }finally{
        isloading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            elevation: 10,
            child: SizedBox(
              width: Responsive.isDesktop(context)
                  ? size.width * 0.3
                  : size.width * 0.5,
              height: Responsive.isDesktop(context)
                  ? size.height * 0.60
                  : size.height * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/moveguiB.jpg',
                    width: size.width * 0.15,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email address",
                      prefixIcon: Icon(IconlyLight.message),
                    ),
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      return MyValidators.emailValidator(value);
                    },
                  ),
                  const SizedBox(height: 16.0),

                  /*
                  CustomTextField(
                    hasIcon: false,
                    onChanged: (data) {
                      username = data.toLowerCase().trim();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'username is required';
                      }else {
                        return null;
                      }
                    },
                    hintText: 'User Name',
                    isNumber: false,
                  ),
                  */

        TextFormField(
                  obscureText: obscureText,
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    hintText: "***********",
                    prefixIcon: const Icon(IconlyLight.lock),
                  ),
                  onFieldSubmitted: (value) async {
                    await _loginFct();
                  },
                  validator: (value) {
                    return MyValidators.passwordValidator(value);
                  },
                ),
                const SizedBox(height: 16.0),

                  /*
                  CustomTextField(
                    hasIcon: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password is required';
                      }
                      if (value.length < 6) {
                        return 'password should be 6 characters or more';
                      }
                      return null;
                    },
                    obscureText: obscureTextForm,
                    onTap: () {
                      setState(() {
                        obscureTextForm = !obscureTextForm;
                      });
                    },
                    onChanged: (data) {
                      try {
                        password = data.trim();
                      } catch (e) {}
                    },
                    hintText: 'Password',
                    isNumber: false,
                  ),
                  */

                           const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(6.0),
                      backgroundColor: AppColors.backgroundColor,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    icon: const Icon(Icons.login, color: AppColors.textColor),
                    label: const Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 32,
                      ),
                    ),
                    onPressed: () async {
                      await _loginFct();
                    },
                  ),
                ),

                  /*

                  TextButton(
                    onPressed: () {
                      if (username != null) {
                        try {
                          UserModel user = users!.firstWhere(
                            (element) => element.userName == username,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ForgetPasswordScreen(pin: user.pinCode),
                            ),
                          );
                        } catch (e) {
                          showErrorAlertBar(context, 'user not found');
                        }
                      } else {
                        showErrorAlertBar(context, 'username can\'t be null');
                      }
                    },
                    child: const Text(
                      'Forget Password ?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  */
                  /*
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Background color
                    ),
                    onPressed: () {
                      final form = formKey.currentState;
                      if (form != null && form.validate()) {
                        form.save();
                        bool isUserFound = false;
                        for (UserModel user in users!) {
                          if (user.userName == username &&
                              user.password == password) {
                            isUserFound = true;
                            break;
                          } else {
                            index = index + 1;
                          }
                        }
                        if (isUserFound) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                          );
                        } else {
                          showErrorAlertBar(
                            context,
                            'Incorrect username or password',
                          );
                        }
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
