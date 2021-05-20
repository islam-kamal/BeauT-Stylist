import 'package:BeauT_Stylist/helpers/appEvent.dart';
import 'package:BeauT_Stylist/helpers/appState.dart';
import 'package:BeauT_Stylist/repo/images_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetImagesBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Hydrate) {
      yield Start(null);
   ress =    await ImagesRepo.GetImages();
      print("Status " + ress.status.toString() + "");
      yield Done(ress);
    }
  }
}

final getImagesBloc = GetImagesBloc();
