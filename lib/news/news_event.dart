part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class LoadPostsEvent extends NewsEvent {}