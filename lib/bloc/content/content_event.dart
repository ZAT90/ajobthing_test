part of 'content_bloc.dart';

@immutable
abstract class ContentEvent {}

class LoadContentList extends ContentEvent {}

class FilterSearchedContent extends ContentEvent {
  final String searchText;

  final List originalList;
  FilterSearchedContent({required this.searchText, required this.originalList});
}

class LoadCandidateDetails extends ContentEvent {
  final CandidateResult candidateResult;
  LoadCandidateDetails({required this.candidateResult});
}

class ListEndReached extends ContentEvent {}

class ListWillMoveUp extends ContentEvent {}

class HideScrollButton extends ContentEvent {}
