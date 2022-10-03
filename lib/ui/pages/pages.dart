import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/shared/shared.dart';
import 'package:bwa_flutix/ui/widgets/widgets.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../bloc/bloc.dart';

part 'main_page.dart';
part 'sign_in_page.dart';
part 'wrapper.dart';
part 'Splash_page.dart';
part 'movie_page.dart';
part 'account_confirmation_page.dart';
part 'signUp_page.dart';
part 'preference_page.dart';

Future<XFile?> getImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? pickedFile;
  pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  // if ((pickedFile = await _picker.pickImage(source: ImageSource.gallery)) !=
  //     null) {
  //   // img = File(pickedFile.path);

  // }
  return pickedFile;
  // return null;
}
