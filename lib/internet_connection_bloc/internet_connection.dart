import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blocs_patteren/internet_connection_bloc/internet_event.dart';
import 'package:blocs_patteren/internet_connection_bloc/internet_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection extends Bloc<InternetEvent , InternetState>{

  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  InternetConnection() : super(InternetInitialState()){

    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));

  connectivitySubscription = connectivity.onConnectivityChanged.listen((event) {
    if(event == ConnectivityResult.mobile || event == ConnectivityResult.wifi){
      add(InternetGainedEvent());
    }else{
      add(InternetLostEvent());
    }
  });
  }
@override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
