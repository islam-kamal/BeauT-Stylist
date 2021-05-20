import 'package:BeauT_Stylist/helpers/appEvent.dart';
import 'package:BeauT_Stylist/helpers/appState.dart';
import 'package:BeauT_Stylist/repo/services_repo.dart';
import 'package:BeauT_Stylist/repo/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetServicesBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    print("InBlocc");
    if (event is Hydrate) {
      yield Start(null);
      ress = await ServicesRepo.GetServices();
      print("InBlocc");
      yield Done(ress);
    }
  }
}

final getServicesBloc = GetServicesBloc();
