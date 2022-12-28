import 'package:bloc/bloc.dart';
import 'package:blocs_patteren/api_practice/data/models/PostModel.dart';
import 'package:blocs_patteren/api_practice/data/models/repositries/post_repositries.dart';
import 'package:blocs_patteren/api_practice/logic/post_state.dart';


class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoadingState()){
    fetchApi();
  }

  PostRepository postRepository = PostRepository();

  void fetchApi() async{
    try{
      List<PostModel> post = await postRepository.fetchApi();
      emit(PostLoadedState(post));
    }catch(ex){
      emit(ErrorState(ex.toString()));
    }
  }
}
