import 'dart:convert';
import 'package:blocs_patteren/api_practice/data/models/PostModel.dart';
import 'package:blocs_patteren/api_practice/data/models/repositries/api/api.dart';
import 'package:blocs_patteren/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostRepository{

 Future<List<PostModel>> fetchApi() async{
   List<PostModel> getPost = [];
  try{
    var response = await http.get(Uri.parse(TestApi.postsApi));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
     if (kDebugMode) {
       print(response.body.toString());
     }
     getPost.clear();
     for(Map i in data){
       getPost.add(PostModel.fromJson(i));
     }
     return getPost;
    }else{
      return getPost;
    }
  }catch(ex, context){
  Utils.message(ex.toString(), context);
  rethrow;
  }
}
}