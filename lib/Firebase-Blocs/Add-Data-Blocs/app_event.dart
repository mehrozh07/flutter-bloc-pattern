import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable{
  @override
  List<Object?> get props => [];

}

class Create extends ProductEvent{
  String? name;
  int? price;
  Create(this.name, this.price);
}
