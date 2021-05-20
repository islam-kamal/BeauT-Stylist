import 'package:bloc/bloc.dart';
import 'package:BeauT_Stylist/helpers/appEvent.dart';
import 'package:BeauT_Stylist/helpers/appState.dart';
import 'package:BeauT_Stylist/repo/user_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ResetPasswordBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);
  final password = BehaviorSubject<String>();
  final confirmPassword = BehaviorSubject<String>();

  Function(String) get updatePassword => password.sink.add;

  Function(String) get updateConfirmPassword => confirmPassword.sink.add;
  String msg;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield (Start(null));
      yield Loading(null);
      var userResponee = await UserDataRepo.RestePassword(
          password.value, confirmPassword.value);
      print("LogIn ResPonse" + userResponee.msg);
      if (userResponee.status == true) {
        yield Done(userResponee);
      } else if (userResponee.status == false) {
        print("Message   ");
        yield ErrorLoading(userResponee);
      }
    }
  }

  dispose() {
    password.close();
    confirmPassword.close();
  }
}

final resetPasswordBloc = ResetPasswordBloc();
