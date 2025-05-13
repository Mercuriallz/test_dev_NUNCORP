import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile_dev/repository/post_repo.dart';
import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository repository;

  PostCubit({required this.repository}) : super(PostInitial());

  Future<void> fetchPosts() async {
    try {
      emit(PostLoading());

      final posts = await repository.fetchPosts();

      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> refreshPosts() async {
    await fetchPosts();
  }
}
