import 'package:auto_route/auto_route.dart';
import 'package:firebasenotesddd/application/auth/auth_bloc.dart';
import 'package:firebasenotesddd/application/notes/note_actor/note_actor_bloc.dart';
import 'package:firebasenotesddd/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:firebasenotesddd/injection.dart';
import 'package:firebasenotesddd/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:firebasenotesddd/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:firebasenotesddd/presentation/routes/router.gr.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                unauthenticated: (_) => ExtendedNavigator.of(context)
                    .pushReplacementNamed(Routes.signInPage),
                orElse: () {},
              );
            },
            child: Container(),
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                deleteFailure: (state) {
                  FlushbarHelper.createError(
                    duration: const Duration(seconds: 5),
                    message: state.noteFailure.map(
                      unexpected: (_) => 'Unexpected error',
                      isufficientPermission: (_) => 'Insufficient permissions ❌',
                      unableToUpdate: (_) => 'Imposible error',
                    ),
                  ).show(context);
                },
                orElse: () {},
              );
            },
            child: Container(),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
                }),
            actions: <Widget>[
              UncompletedSwitch(),
            ],
          ),
          body: NotesOverviewBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //TODO: navigate to noteFormPage
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
