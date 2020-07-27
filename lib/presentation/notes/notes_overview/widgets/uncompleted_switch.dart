import 'package:firebasenotesddd/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UncompletedSwitch extends HookWidget {
  const UncompletedSwitch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toggleState = useState(false);
    context.bloc<NoteWatcherBloc>().add(
          toggleState.value
              ? const NoteWatcherEvent.watchUncompletedStarted()
              : const NoteWatcherEvent.watchAllStarted(),
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkResponse(
        onTap: () {
          toggleState.value = !toggleState.value;
        },
        child: AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 250,
          ),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: toggleState.value
              ? Icon(
                  Icons.check_box_outline_blank,
                  key: const Key('outline'),
                )
              : Icon(
                  Icons.indeterminate_check_box,
                  key: const Key('indeterminate'),
                ),
        ),
      ),
    );
  }
}
