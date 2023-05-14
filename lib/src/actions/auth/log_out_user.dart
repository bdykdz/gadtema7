part of '../index.dart';

@freezed
class LogOut with _$LogOut {
  const factory LogOut.start() = LogOutStart;
  const factory LogOut.successful() = LogOutSuccessful;
  const factory LogOut.error(Object error, StackTrace stackTrace) = LogOutError;
}
