import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_mobile_dev/models/post.dart';

class PostRepository {
  static const String _baseUrl = "https://jsonplaceholder.typicode.com";
  static const String _cacheKey = "cached_posts";

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/posts"))
          .timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final posts = jsonList.map((json) => Post.fromJson(json)).toList();
        
        cachePosts(jsonList);
        
        return posts;
      } else {
        throw Exception("Gagal load post ==> : ${response.statusCode}");
      }
    } on SocketException {
      return getCachedPosts();
    } catch (e) {
      throw Exception("Post gagal di fetch ==> : $e");
    }
  }

  Future<void> cachePosts(List<dynamic> jsonList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, json.encode(jsonList));
    } catch (e) {
      throw Exception("Gagal cache postsss ==> : $e");
    }
  }

  Future<List<Post>> getCachedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString(_cacheKey);
    
    if (cachedData != null) {
      final List<dynamic> jsonList = json.decode(cachedData);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Ga ada data di cache");
    }
  }
}