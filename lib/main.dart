import 'package:firebasenotesddd/injection.dart';
import 'package:firebasenotesddd/presentation/core/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

void main() {
  configureInjection(Environment.prod);
  runApp(AppWidget());
  }

