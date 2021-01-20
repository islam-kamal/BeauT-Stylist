// import 'package:butyprovider/helpers/appEvent.dart';
// import 'package:butyprovider/helpers/appState.dart';
// import 'package:butyprovider/repo/user_journy.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class HomePageBloc extends Bloc<AppEvent, AppState> {
//   @override
//   AppState get initialState => Start(null);
//
//   var ress;
//
//   @override
//   Stream<AppState> mapEventToState(AppEvent event) async* {
//     if (event is Hydrate) {
//       print("asdasdas");
//       yield Start(null);
//       ress = await UserJourny.GetHomePageData();
//       yield Done(ress);
//     }
//   }
// }
//
// final homePageBloc = HomePageBloc();
