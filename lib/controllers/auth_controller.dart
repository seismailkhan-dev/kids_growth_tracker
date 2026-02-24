import 'package:family_health_tracker/controllers/app_controller.dart';
import 'package:family_health_tracker/views/dashboard/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/constants/firebaes_fields_names.dart';
import '../core/services/firebase_collections_service.dart';
import '../core/services/loading_service.dart';
import '../core/services/sharedpref_service.dart';
import '../core/widgets/custom_snack_bar.dart';
import '../models/user.dart';

enum UserRole { admin, driver }

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserRole> selectedUserRole = Rx<UserRole>(UserRole.admin);


  RxBool isLoading = false.obs;
  RxBool isObscureText = true.obs;
  RxBool agreeTerms = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   firebaseUser.bindStream(_auth.authStateChanges());
  // }

  changeObscure(){
    isObscureText.value = !isObscureText.value;
  }

  changeAgreeTerm(bool value){
    agreeTerms.value = value;
  }
  /// ==================== DRIVER EMAIL CONVERTER ====================


  /// ==================== ADMIN SIGNUP ====================
  Future<void> signupUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      customSnackBar("Error", "Confirm password did not matched.");
      return;
    }

    if (!agreeTerms.value) {
      customSnackBar("Error", "Please accept Terms of Services and Privacy Policy");
      return;
    }


    try {
      isLoading(true);

      // LoadingService.show(message: "Creating account...");

      // Firebase Auth Signup
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


      // Save admin user info
      await FirebaseCollectionService.users.doc(cred.user!.uid).set({
        FirebaseFieldsNames.uid: cred.user!.uid,
        FirebaseFieldsNames.firstName: firstNameController.text.trim(),
        FirebaseFieldsNames.lastName: lastNameController.text.trim(),
        FirebaseFieldsNames.phone: phoneController.text.trim(),
        FirebaseFieldsNames.email: email,
        FirebaseFieldsNames.createdAt: FieldValue.serverTimestamp(),
        FirebaseFieldsNames.updatedAt: FieldValue.serverTimestamp(),
        FirebaseFieldsNames.isPremiumUser: false,
      });

      navigateToDashboard(userId: cred.user!.uid, userData: UserModel(
          uid: cred.user!.uid,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isPremiumUser: false
      ));


      customSnackBar("Success", "Account created successfully",isSuccess: true);

    } on FirebaseAuthException catch (e) {
      customSnackBar(
        "Signup Error",
        e.message ?? "Authentication failed",
      );
    }  catch (e) {
      print("Error:: $e");
      customSnackBar("Signup Error",   e.toString().replaceFirst('Exception: ', ''));
    }finally{
      isLoading(false);
    }
  }

  /// ==================== ADMIN LOGIN ====================
  Future<void> loginUser() async {

    try {

      isLoading(true);

      String email = emailController.text.trim();


      UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: passwordController.text.trim()) .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception("Firebase login timed out");
        },
      );;

      print('cred: ${cred}');
      print('cred.user!.uid : ${cred.user!.uid}');
     DocumentSnapshot userData = await FirebaseCollectionService.users.doc(cred.user!.uid).get();

    if(userData.data()==null){
      customSnackBar(
        "Login Error",
         "Authentication failed",
      );
    }else{
      UserModel userModel = UserModel.fromJson(userData.data() as Map<String, dynamic>);

      navigateToDashboard(userId: cred.user!.uid, userData: userModel);

      customSnackBar("Success", "Login Successful",isSuccess: true);
    }

    } on FirebaseAuthException catch (e) {

      customSnackBar(
        "Login Error",
        e.message ?? "Authentication failed",
      );
    }catch (e) {
      debugPrint("Login Error: $e");
      customSnackBar("Login Error", e.toString().replaceFirst('Exception: ', ''));
    }finally{
      isLoading(false);
    }
  }



  navigateToDashboard({required String userId,required UserModel userData}) async {
    await SharedPrefService.saveIsLoggedIn(true);
    await SharedPrefService.saveIsLoggedInTime(DateTime.now());
    await SharedPrefService.saveUserModel(userData);

    final controller = Get.find<AppController>();

    controller.userData.value = userData;
    controller.isPremium.value = userData.isPremiumUser??false;

    Get.offAll(DashboardScreen());
  }


}
