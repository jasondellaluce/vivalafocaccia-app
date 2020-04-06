import 'package:equatable/equatable.dart';

abstract class SearchResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchResult extends SearchResultEvent {}

class GoToPrevPage extends SearchResultEvent {}