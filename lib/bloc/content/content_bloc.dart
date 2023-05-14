import 'dart:math';

import 'package:ajobthing_test/main.dart';
import 'package:ajobthing_test/model/address.dart';
import 'package:ajobthing_test/model/blog.dart';
import 'package:ajobthing_test/model/candidate.dart';
import 'package:ajobthing_test/model/contact.dart';
import 'package:ajobthing_test/model/experience.dart';
import 'package:ajobthing_test/services/api/contentAPI.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentApi contentApi = ContentApi();
  ContentBloc() : super(ContentInitial()) {
    on<LoadContentList>(
        (event, emit) async => await mapContentList(event, emit));
    on<FilterSearchedContent>(
        (event, emit) async => await mapSearchedContent(event, emit));
    on<LoadCandidateDetails>(
        (event, emit) async => await mapCandidateDetails(event, emit));
    on<ListEndReached>((event, emit) => emit(GetListEndReached()));
    on<ListWillMoveUp>((event, emit) => emit(GetListMoveUp()));
    on<HideScrollButton>((event, emit) => emit(ScrollButtonHidden()));
  }

  Future<void> mapContentList(
      LoadContentList event, Emitter<ContentState> emit) async {
    try {
      List contentList = [];
      Response blogRes = await contentApi.getBlogs();
      Response contentRes = await contentApi.getCandidates();
      // logger.d('response status blogres: ${blogRes.statusCode}');
      // logger.d('response status contentRes: ${contentRes.statusCode}');
      if (blogRes.statusCode == 200) {
        Blog blog = Blog.fromJson(blogRes.data);
        contentList.addAll(blog.results!);
      }
      if (contentRes.statusCode == 200) {
        Candidate candidate = Candidate.fromJson(contentRes.data);
        contentList.addAll(candidate.results!);
      }

      if (blogRes.statusCode != 200 && contentRes.statusCode != 200) {
        emit(GetApiError(errorMsg: 'unable to load data from API'));
      } else {
        emit(GetContentList(contentList: contentList..shuffle()));
      }
    } catch (e) {
      logger.d('LoadContentList exception: $e');
      emit(GetApiError(errorMsg: 'unable to load data from API'));
    }
  }

  Future<void> mapSearchedContent(
      FilterSearchedContent event, Emitter<ContentState> emit) async {
    // logger.d('search string: ${event.searchText}');
    List searchedList = [];
    List<CandidateResult> candidateList = event.originalList
        .whereType<CandidateResult>()
        .where((element) => element.name!
            .toLowerCase()
            .contains(event.searchText.toLowerCase()))
        .toList();
    // add filtered result from candidate list to dynamic list
    searchedList.addAll(candidateList);
    List<BlogResult> blogList = event.originalList
        .whereType<BlogResult>()
        .cast<BlogResult>()
        .where((element) =>
            element.author!
                .toLowerCase()
                .contains(event.searchText.toLowerCase()) ||
            element.title!
                .toLowerCase()
                .contains(event.searchText.toLowerCase()))
        .toList();
    // add filtered result from blog list to dynamic list
    searchedList.addAll(blogList);
    // logger.d('candidate length: ${candidateList.length}');
    // logger.d('blog length: ${blogList.length}');
    emit(GetSearchedList(
        searchText: event.searchText, searchedList: searchedList));
  }

  Future<void> mapCandidateDetails(
      LoadCandidateDetails event, Emitter<ContentState> emit) async {
    try {
      logger.d('check candidate detail: ${event.candidateResult}');
      Response addressRes = await contentApi.getAddresses();
      Response contactRes = await contentApi.getContacts();
      Response experienceRes = await contentApi.getExperiences();
      Address address = Address.fromJson(addressRes.data);
      Contact contact = Contact.fromJson(contactRes.data);
      Experience experience = Experience.fromJson(experienceRes.data);

      AddressResult addressResult = address.results!.firstWhere(
          (element) => element.id == event.candidateResult.id,
          orElse: () => AddressResult());
      ContactResult contactResult = contact.results!.firstWhere(
          (element) => element.id == event.candidateResult.id,
          orElse: () => ContactResult());
      ExperienceResult experienceResult = experience.results!.firstWhere(
        (element) => element.id == event.candidateResult.id,
        orElse: () => ExperienceResult(),
      );
      // logger.d('addressRes: $addressRes');
      // logger.d('emailRes: $emailRes');
      // logger.d('experienceRes: $experienceRes');
      if (addressRes.statusCode != 200 &&
          contactRes.statusCode != 200 &&
          experienceRes.statusCode != 200) {
        emit(GetApiError(errorMsg: 'unable to load data from API'));
      } else {
        emit(GetCandidateDetails(
            candidateResult: event.candidateResult,
            addressResult: addressResult,
            contactResult: contactResult,
            experienceResult: experienceResult));
      }
    } catch (e) {
      logger.d('LoadCandidateDetails exception: $e');
      emit(GetApiError(errorMsg: 'unable to load data from API'));
    }
  }
}
