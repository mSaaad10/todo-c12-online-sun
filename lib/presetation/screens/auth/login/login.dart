import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app_c12_online_sun/core/utils/app_styles.dart';
import 'package:todo_app_c12_online_sun/core/utils/assets_manager.dart';
import 'package:todo_app_c12_online_sun/core/utils/constant_manager.dart';
import 'package:todo_app_c12_online_sun/core/utils/dialog_utils/dialog_utils.dart';
import 'package:todo_app_c12_online_sun/core/utils/email_validation.dart';
import 'package:todo_app_c12_online_sun/core/utils/routes_manager.dart';
import 'package:todo_app_c12_online_sun/database/model/user_DM.dart';
import 'package:todo_app_c12_online_sun/presetation/screens/auth/widgets/custom_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: REdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  AssetsManager.routeImage,
                  width: 237.w,
                  height: 71.h,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  'E-mail',
                  style: AppLightStyles.title,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomField(
                  hintText: 'enter your email address',
                  keyBoardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter email';
                    }
                    if (!isValidEmail(input)) {
                      // true -> email is valid
                      return 'Email bad format';
                    }
                    //
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  'Password',
                  style: AppLightStyles.title,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomField(
                  hintText: 'enter your password',
                  keyBoardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  isSecure: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                MaterialButton(
                  padding: REdgeInsets.symmetric(vertical: 11),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  onPressed: () {
                    signIn();
                  },
                  child: Text(
                    'Sign-In',
                    style: AppLightStyles.buttonTitle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?",
                      style: AppLightStyles.title?.copyWith(fontSize: 14),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesManager.register);
                        },
                        child: Text(
                          'Create account',
                          style: AppLightStyles.title?.copyWith(
                              fontSize: 14,
                              decoration: TextDecoration.underline),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    // step1 -> check if form valid ?
    // step2-> create user
    if (formKey.currentState?.validate() == false) return;

    // create user
    try {
      DialogUtils.showLoading(context, message: 'Wait...');
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, //
        password: passwordController.text,
      );
      UserDM.currentUser = await readUserFromFireStore(credential.user!.uid);

      if (mounted) {
        DialogUtils.hide(context);
      }
      DialogUtils.showMessage(
        context,
        body: 'User logged in successfully',
        posActionTitle: 'Ok',
        posAction: () {
          Navigator.pushReplacementNamed(
            context,
            RoutesManager.home,
          );
        },
      );
    } on FirebaseAuthException catch (authError) {
      DialogUtils.hide(context);
      late String message;
      if (authError.code == ConstantManager.invalidCredentialCode) {
        message = 'Wrong email password';
      }
      DialogUtils.showMessage(
        context,
        body: message,
        posActionTitle: 'Ok',
      );
    } catch (error) {
      DialogUtils.hide(context);
      DialogUtils.showMessage(context, body: error.toString());
    }
  }

  Future<UserDM> readUserFromFireStore(String uid) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);

    DocumentReference userDoc = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapShot = await userDoc.get();
    Map<String, dynamic> json = userDocSnapShot.data() as Map<String, dynamic>;
    UserDM userDM = UserDM.fromFireStore(json);
    return userDM;
  }
}
