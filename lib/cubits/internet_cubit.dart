import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum InternetState{initial, lostState,gainedState}

class InternetCubit extends Cubit<InternetState> {
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  InternetCubit() : super(InternetState.initial){
    connectivitySubscription = connectivity.onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.mobile || event == ConnectivityResult.wifi){
        emit(InternetState.gainedState);
      }else{
        emit(InternetState.lostState);
      }
    });
  }
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
