import 'package:firebasenotesddd/domain/core/value_objects.dart';
import 'package:firebasenotesddd/domain/notes/todo_item.dart';
import 'package:firebasenotesddd/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_dtos.freezed.dart';
part 'note_dtos.g.dart';

@freezed
abstract class NoteDto with _$NoteDto{
  const factory NoteDto({
    @JsonKey(ignore: true) String id,
    @required String body,
    @required int color,
    @required List<TodoItemDto> todos,
  }) = _NoteDto;

  factory NoteDto.fromJson(Map<String, dynamic> json) => _$NoteDtoFromJson(json);
}


@freezed
abstract class TodoItemDto implements _$TodoItemDto {
  const TodoItemDto._();

  const factory TodoItemDto({
    @required String id,
    @required String name,
    @required bool done,
  }) = _TodoItemDto;

  factory TodoItemDto.fromDomain(TodoItem todoItem) {
    return TodoItemDto(
      id: todoItem.id.getOrCrash(),
      name: todoItem.name.getOrCrash(),
      done: todoItem.done,
    );
  }

  TodoItem toDomain() {
    return TodoItem(
      id: UniqueId.fromUniqueString(id),
      name: TodoName(name),
      done: done,
    );
  }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) => _$TodoItemDtoFromJson(json);
}
