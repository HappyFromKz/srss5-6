import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practice_7/news/news_repository.dart';
import 'package:practice_7/news/post.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _NewsRepository;

  NewsBloc(this._NewsRepository) : super(NewsLoading()) {
    on<LoadPostsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        final posts = await _NewsRepository.getPosts();
        emit(NewsLoaded(posts));
      } catch (e) {
        emit(NewsError('Failed to load posts: $e'));
      }
    });
  }
}