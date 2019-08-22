import 'actons.dart';

int mainReducer(int state, dynamic action) {
  if (Actions.Increase == action) {
    return state + 1;
  }

  return state;
}
