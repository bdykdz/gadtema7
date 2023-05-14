import 'package:flutter/foundation.dart';

import '../actions/index.dart';
import '../models/index.dart';
import 'auth_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  if (kDebugMode) {
    print(action);
  }

  if (action is LogOutSuccessful) {
    return const AppState();
  }

  return state.copyWith(auth: authReducer(state.auth, action));
}
