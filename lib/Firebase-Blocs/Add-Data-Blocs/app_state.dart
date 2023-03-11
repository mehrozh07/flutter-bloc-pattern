part of 'app_bloc.dart';

@immutable
abstract class ProductState extends Equatable {}

class InitialState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductAdding extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductAdded extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductError extends ProductState {

   String? error;
   ProductError(this.error);
   @override
   List<Object?> get props => [error];
}


