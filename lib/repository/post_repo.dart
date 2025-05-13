import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_mobile_dev/models/post.dart';

class PostRepository {
  static const String _baseUrl = "https://jsonplaceholder.typicode.com";
  static const String cacheKey = "cached_posts";
  final dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await dio.get('/posts');
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final posts = jsonList.map((json) => Post.fromJson(json)).toList();
        
        cachePosts(jsonList);
        
        return posts;
      } else {
        throw Exception("Gagal load post ==> : ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return getCachedPosts();
      }
      throw Exception("Post gagal di fetch ==> : ${e.message}");
    } catch (e) {
      throw Exception("Post gagal di fetch ==> : $e");
    }
  }

  Future<void> cachePosts(List<dynamic> jsonList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(cacheKey, json.encode(jsonList));
    } catch (e) {
      throw Exception("Gagal cache postsss ==> : $e");
    }
  }

  Future<List<Post>> getCachedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString(cacheKey);
    
    if (cachedData != null) {
      final List<dynamic> jsonList = json.decode(cachedData);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Ga ada data di cache");
    }
  }
}