// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebasenotesddd/infrastructure/core/firebase_injectable_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebasenotesddd/infrastructure/auth/firebase_auth_facade.dart';
import 'package:firebasenotesddd/domain/auth/i_auth_facade.dart';
import 'package:firebasenotesddd/infrastructure/notes/note_repository.dart';
import 'package:firebasenotesddd/domain/notes/i_note_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasenotesddd/application/notes/note_actor/note_actor_bloc.dart';
import 'package:firebasenotesddd/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:firebasenotesddd/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:firebasenotesddd/application/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  g.registerLazySingleton<FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  g.registerLazySingleton<GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  g.registerLazySingleton<IAuthFacade>(
      () => FirebaseAuthFacade(g<FirebaseAuth>(), g<GoogleSignIn>()));
  g.registerLazySingleton<INoteRepository>(
      () => NoteRepository(g<Firestore>()));
  g.registerFactory<NoteActorBloc>(() => NoteActorBloc(g<INoteRepository>()));
  g.registerFactory<NoteWatcherBloc>(
      () => NoteWatcherBloc(g<INoteRepository>()));
  g.registerFactory<SignInFormBloc>(() => SignInFormBloc(g<IAuthFacade>()));
  g.registerFactory<AuthBloc>(() => AuthBloc(g<IAuthFacade>()));
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
