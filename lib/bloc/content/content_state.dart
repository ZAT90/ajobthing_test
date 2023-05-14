part of 'content_bloc.dart';

@immutable
abstract class ContentState {}

class ContentInitial extends ContentState {}

class GetContentList extends ContentState {
  final List contentList;
  GetContentList({required this.contentList});
}

class GetSearchedList extends ContentState {
  final String searchText;
  final List searchedList;

  GetSearchedList({
    required this.searchText,
    required this.searchedList,
  });
}

class GetApiError extends ContentState {
  final String errorMsg;
  GetApiError({required this.errorMsg});
}

class GetCandidateDetails extends ContentState {
  final CandidateResult candidateResult;
  final AddressResult addressResult;
  final ContactResult contactResult;
  final ExperienceResult experienceResult;
  GetCandidateDetails(
      {required this.candidateResult,
      required this.addressResult,
      required this.contactResult,
      required this.experienceResult});
}

class GetListEndReached extends ContentState {}

class GetListMoveUp extends ContentState {}

class ScrollButtonHidden extends ContentState {}
