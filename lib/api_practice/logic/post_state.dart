
import 'package:blocs_patteren/api_practice/data/models/PostModel.dart';

abstract class PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
   final List<PostModel> posts;
   PostLoadedState(this.posts);
}

class ErrorState extends PostState {
  final String error;
  ErrorState(this.error);
}
