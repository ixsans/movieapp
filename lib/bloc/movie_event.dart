part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchMovieEvent extends MovieEvent {
  const FetchMovieEvent();

  @override
  List<Object> get props => [];
}
