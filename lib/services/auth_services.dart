part of 'services.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Future<SignInSignUpResult> singUp(
    String email,
    String password,
    String name,
    List<String> selectedGenres,
    String selectedLanguange,
    // int balance,
  ) async {
    try {
      // if (email != '') {

      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // }

      // UserModel user = result.user.convertToUser(
      //   name: name,
      //   balance:
      //   selectedGenres: selectedGenres,
      //   selectedLanguange: selectedLanguange,
      // )
      UserModel user = result.user!.convertToUserModel(
        name: name,
        selectedGenres: selectedGenres,
        selectedlanguage: selectedLanguange,
        // balance: balance,
      );
      log(user.toString());
      await UserServices.updateUser(user);

      return SignInSignUpResult(user: user);
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'weak-password') {
      //   print(e.code);
      // } else if (e.code == 'email-already-in-use') {
      //   print(e.code);
      // } else if (e.code == 'user-not-found') {
      //   print(e.code);
      // } else if (e.code == 'wrong-password') {
      //   print(e.code);
      // }
      return SignInSignUpResult(message: e);
    }
  }

  static Future<SignInSignUpResult> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      UserModel userFromModel = await result.user!.fromFireStore();
      return SignInSignUpResult(user: userFromModel);
    } on FirebaseAuthException catch (e) {
      return SignInSignUpResult(message: e);
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Stream<User?> get userStream => _auth.authStateChanges();
}

class SignInSignUpResult {
  UserModel? user;
  FirebaseAuthException? message;

  SignInSignUpResult({this.user, this.message});
}

// class AuthenticationHelper {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   get user => _auth.currentUser;

//   Future signUp({String? email, String? password}) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//         email: email!,
//         password: password!,
//       );
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }
// }
