import 'package:BeauT_Stylist/helpers/appEvent.dart';
import 'package:BeauT_Stylist/helpers/appState.dart';
import 'package:BeauT_Stylist/repo/user_journy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CurrentOrdersBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);
  final type = BehaviorSubject<String>();

  Function(String) get updateType => type.sink.add;
  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Hydrate) {
      yield Start(null);
      ress = await UserJourny.GETCURRENTORDERS();
      print("Status " + ress.status.toString() + "");
      yield Done(ress);
    }
  }
}

final currentOrdersBloc = CurrentOrdersBloc();
