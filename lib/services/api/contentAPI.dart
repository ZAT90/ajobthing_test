import 'package:ajobthing_test/services/api/baseApi.dart';

class ContentApi extends BaseApi {
  @override
  // TODO: implement path
  get path => '';
  static final ContentApi _instance = ContentApi();
  static ContentApi get instance {
    return _instance;
  }

  Future getCandidates() {
    return dio.get('$path/candidates');
  }

  Future getBlogs() {
    return dio.get('$path/blogs');
  }

  Future getAddresses() {
    return dio.get('$path/address');
  }

  Future getContacts() {
    return dio.get('$path/emails');
  }

  Future getExperiences() {
    return dio.get('$path/experiences');
  }
}
