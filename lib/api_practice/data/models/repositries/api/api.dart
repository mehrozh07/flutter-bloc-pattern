
import 'package:http/http.dart' as http;

class TestApi{
  // Uri? _uri = Uri();
  // Uri? get sendRequest => _uri;
  // http(){
  //   _uri = Uri.http('https://jsonplaceholder.typicode.com');
  //   return _uri;
  // }

  static const String baseApi = "https://jsonplaceholder.typicode.com/";
  static const String postsApi = "${baseApi}posts";
  static const String countriesList = "${baseApi}countries";
}