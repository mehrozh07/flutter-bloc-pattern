import 'package:bloc/bloc.dart';
import 'package:blocs_patteren/Firebase-Blocs/Add-Data-Blocs/app_event.dart';
import 'package:blocs_patteren/Repo/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'app_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({required this.productRepository}) : super(InitialState()) {
    on<Create>((event, emit) async{
      emit(ProductAdding());
      try{
       await productRepository.addProducts(name: event.name, price: event.price);
       emit(ProductAdded());

      }catch(e){
        emit(ProductError(e.toString()));
      }

    });
  }
}
