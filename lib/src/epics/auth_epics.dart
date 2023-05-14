import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import '../actions/index.dart';
import '../data/auth_api.dart';
import '../models/index.dart';

class AuthEpics implements EpicClass<AppState> {
  AuthEpics(this._api);

  final AuthApi _api;

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, CreateUserStart>(_createUserStart).call,
      TypedEpic<AppState, LoginUserStart>(_loginUserStart).call,
      TypedEpic<AppState, CheckUserStart>(_checkUserStart).call,
      TypedEpic<AppState, LogOutStart>(_logOutUserStart).call,
    ])(actions, store);
  }

  Stream<dynamic> _createUserStart(Stream<CreateUserStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((CreateUserStart actions) {
      return Stream<void>.value(null)
          .asyncMap((_) => _api.createUser(email: actions.email, password: actions.password))
          .map((AppUser user) => CreateUser.successful(user))
          .onErrorReturnWith((Object error, StackTrace stackTrace) => CreateUser.error(error, stackTrace))
          .doOnData(actions.result);
    });
  }

  Stream<dynamic> _loginUserStart(Stream<LoginUserStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((LoginUserStart actions) {
      return Stream<void>.value(null)
          .asyncMap((_) => _api.loginUser(email: actions.email, password: actions.password))
          .map((AppUser user) => LoginUser.successful(user))
          .onErrorReturnWith((Object error, StackTrace stackTrace) => LoginUser.error(error, stackTrace))
          .doOnData(actions.result);
    });
  }

  Stream<dynamic> _checkUserStart(Stream<CheckUserStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((CheckUserStart actions) {
      return Stream<void>.value(null)
          .asyncMap((_) => _api.checkUser())
          .map((AppUser? user) => CheckUser.successful(user))
          .onErrorReturnWith((Object error, StackTrace stackTrace) => CheckUser.error(error, stackTrace));
    });
  }

  Stream<dynamic> _logOutUserStart(Stream<LogOutStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((LogOutStart actions) {
      return Stream<void>.value(null)
          .asyncMap((_) => _api.logOut())
          .mapTo(const LogOut.successful())
          .onErrorReturnWith((Object error, StackTrace stackTrace) => LogOut.error(error, stackTrace));
    });
  }
}
