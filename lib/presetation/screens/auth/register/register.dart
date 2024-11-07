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

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController fullNameController;

  late TextEditingController userNameController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController rePasswordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
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
                Text(
                  'Full name',
                  style: AppLightStyles.title,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomField(
                  hintText: 'enter your full name',
                  keyBoardType: TextInputType.name,
                  controller: fullNameController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter full name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  'user name',
                  style: AppLightStyles.title,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomField(
                  hintText: 'enter user name',
                  keyBoardType: TextInputType.name,
                  controller: userNameController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter user name';
                    }
                    return null;
                  },
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
                Text(
                  're-password',
                  style: AppLightStyles.title,
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomField(
                  hintText: 'Password confirmation',
                  keyBoardType: TextInputType.visiblePassword,
                  isSecure: true,
                  controller: rePasswordController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, confirm password';
                    }
                    if (input != passwordController.text) {
                      return "Password doesn't match";
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
                    signUp();
                  },
                  child: Text(
                    'Sign-Up',
                    style: AppLightStyles.buttonTitle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account?",
                      style: AppLightStyles.title?.copyWith(fontSize: 14),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesManager.login);
                        },
                        child: Text(
                          'Sign-In',
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

  void signUp() async {
    // step1 -> check if form valid ?
    // step2-> create user
    if (formKey.currentState?.validate() == false) return;

    // create user

    try {
      DialogUtils.showLoading(context, message: 'Wait...');
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, //
        password: passwordController.text,
      );
      addUserToFireStore(credential.user!.uid);
      print(credential.user!.uid);
      if (mounted) {
        DialogUtils.hide(context);
      }
      DialogUtils.showMessage(
        context,
        body: 'User registered successfully',
        posActionTitle: 'Ok',
        posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.login);
        },
      );
    } on FirebaseAuthException catch (authError) {
      DialogUtils.hide(context);
      late String message;
      if (authError.code == ConstantManager.weakPasswordCode) {
        message = 'The password provided is too weak.';
      } else if (authError.code == ConstantManager.emailAlreadyInUseCode) {
        message = 'The account already exists for that email.';
      }
      DialogUtils.showMessage(
        context,
        title: 'Error occurred',
        body: message,
        posActionTitle: 'Ok',
      );
    } catch (error) {
      DialogUtils.hide(context);
      DialogUtils.showMessage(context,
          title: 'Error Occurred', body: error.toString());
    }
  }

  void addUserToFireStore(String uid) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDocument = usersCollection.doc(uid);
    UserDM userDM = UserDM(
        id: uid,
        fullName: fullNameController.text,
        userName: userNameController.text,
        email: emailController.text);
    await userDocument.set(userDM.toFireStore());
  }
}
