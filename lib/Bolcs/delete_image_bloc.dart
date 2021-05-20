import 'package:bloc/bloc.dart';
import 'package:BeauT_Stylist/helpers/appEvent.dart';
import 'package:BeauT_Stylist/helpers/appState.dart';
import 'package:BeauT_Stylist/repo/images_repo.dart';
import 'package:BeauT_Stylist/repo/user_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DeleteImageBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  // ignore: close_sinks
  final id = BehaviorSubject<int>();

  Function(int) get updateEmail => id.sink.add;
  String msg;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield (Start(null));
      yield Loading(null);
      print("deleting image ===== > ID = ${id.value} From Bloc Layer");
      var userResponee = await ImagesRepo.deleteImage(id.value);
      print(" ResPonse" + userResponee.msg);
      if (userResponee.status == true) {
        yield Done(userResponee);
      } else if (userResponee.status ) {
        print("Message   ");
        yield ErrorLoading(userResponee);
      }
    }
  }

}

final deleteImageBloc = DeleteImageBloc();
