import 'dart:convert';
import 'package:http/http.dart';
import 'package:practice_7/news/post.dart';

class NewsRepository {
  Future<List<Post>> getPosts() async {
    Response response = await get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}