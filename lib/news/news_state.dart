part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Post> posts;

  NewsLoaded(this.posts);
}

class NewsError extends NewsState {
  final String errorMessage;

  NewsError(this.errorMessage);
}