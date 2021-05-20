import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:BeauT_Stylist/helpers/appEvent.dart';
import 'package:BeauT_Stylist/helpers/appState.dart';
import 'package:BeauT_Stylist/helpers/shared_preference_manger.dart';
import 'package:BeauT_Stylist/repo/user_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class SignUpBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final email = BehaviorSubject<String>();
  final owner_name = BehaviorSubject<String>();
  final beaut_name = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();
  final mobile = BehaviorSubject<String>();
  final address = BehaviorSubject<String>();
  final lat = BehaviorSubject<double>();
  final lng = BehaviorSubject<double>();
  final photos = BehaviorSubject<List<File>>();
  final payment = BehaviorSubject<List<int>>();
  final city_id = BehaviorSubject<int>();
  final insta_link = BehaviorSubject<String>();
  final photo = BehaviorSubject<File>();

  Function(List<File>) get updateImages => photos.sink.add;

  Function(List<int>) get updatepayment => payment.sink.add;

  Function(int) get updateCityId => city_id.sink.add;

  Function(String) get updateEmail => email.sink.add;

  Function(String) get updateName => owner_name.sink.add;

  Function(String) get updateMobile => mobile.sink.add;

  Function(String) get updatePassword => password.sink.add;

  Function(String) get updateAddress => address.sink.add;

  Function(String) get updateButeName => beaut_name.sink.add;

  Function(String) get updateInstalink => insta_link.sink.add;

  Function(double) get updateLat => lat.sink.add;

  Function(double) get updateLng => lng.sink.add;

  Function(File) get updateimagee => photo.sink.add;

  String msg;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield Loading(null);
      var response = await UserDataRepo.SIGNUP(
          payment: payment.value,
          photo: photo.value,
          photos: photos.value,
          beaut_name: beaut_name.value,
          address: address.value,
          email: email.value,
          lat: lat.value,
          insta_link: insta_link.value,
          city_id: city_id.value,
          lng: lng.value,
          mobile: mobile.value,
          owner_name: owner_name.value,
          password: password.value);
      print("LogIn ResPonse" + response.msg);
      if (response.status == true) {
        print(response);
        SharedPreferenceManager preferenceManager = SharedPreferenceManager();
        preferenceManager.writeData(CachingKey.EMAIL, email.value);
        yield Done(response);
      } else if (response.status == false) {
        print("Error Loading Event ");
        yield ErrorLoading(response);
      }
    }
  }
}

final signUpBloc = SignUpBloc();
