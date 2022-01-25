part of 'home_bloc.dart';


enum PostStatus { initial, success, failure }

@immutable
class HomeState extends Equatable{

  const HomeState({
    this.status = PostStatus.initial,
    this.posts
  });

  final PostStatus status;
  final Post? posts;


  HomeState copyWith({
    PostStatus? status,
    Post? posts,
  }) {
    return HomeState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object?> get props => [status, posts];

}
