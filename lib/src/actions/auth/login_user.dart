part of '../index.dart';

@freezed
class LoginUser with _$LoginUser {
  const factory LoginUser.start({required String email, required String password, required ActionResult result}) =
      LoginUserStart;
  @Implements<UserAction>()
  const factory LoginUser.successful(AppUser user) = LoginUserSuccessful;
  const factory LoginUser.error(Object error, StackTrace stackTrace) = LoginUserError;
}
