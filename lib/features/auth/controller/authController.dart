import 'package:awafi_pos/features/auth/repository/authRepository.dart';
import 'package:awafi_pos/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Branches/branches.dart';
import '../../../flutter_flow/upload_media.dart';

final authControllerProvider = StateProvider((ref) {
  return AuthController(
      authRepository: ref.watch(authRepositoryProvider));
});

class AuthController{
  AuthRepository _authRepository;

  AuthController({
    required AuthRepository authRepository
}) : _authRepository = authRepository;

  loginUser({required String email, required String password, required BuildContext context}) async {
    var result = await _authRepository.loginUser(email: email, password: password);

    result.fold(
        (l) =>
    showUploadMessage(context, l.message),
        (r) {
           FirebaseAuth _auth= FirebaseAuth.instance;
          var user = _auth.currentUser;
          currentUserId=user!.uid;

          Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) =>
              BranchPageWidget()));
        }

    );

  }

}