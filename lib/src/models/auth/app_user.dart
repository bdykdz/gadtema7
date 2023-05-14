part of '../index.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({required String id, required String userName, required String email, String? profileImages}) =
      AppUser$;

  factory AppUser.fromJson(Map<dynamic, dynamic> json) => _$AppUserFromJson(Map<String, dynamic>.from(json));
}
