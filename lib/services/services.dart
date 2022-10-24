import 'dart:convert';
import 'dart:developer';

import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bwa_flutix/extension/extensions.dart';
import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

part 'auth_services.dart';
part 'user_services.dart';
part 'movie_services.dart';
part 'ticket_services.dart';
part 'flutix_transaction_services.dart';
