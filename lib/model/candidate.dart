class Candidate {
  List<CandidateResult>? results;

  Candidate({this.results});

  Candidate.fromJson(Map<String, dynamic> json) {
    results = json["results"] == null
        ? null
        : (json["results"] as List)
            .map((e) => CandidateResult.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data["results"] = results?.map((e) => e.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ results: $results }';
  }
}

class CandidateResult {
  int? id;
  String? name;
  String? gender;
  String? photo;
  int? birthday;
  int? expired;

  CandidateResult(
      {this.id,
      this.name,
      this.gender,
      this.photo,
      this.birthday,
      this.expired});

  CandidateResult.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    gender = json["gender"];
    photo = json["photo"];
    birthday = json["birthday"];
    expired = json["expired"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["gender"] = gender;
    data["photo"] = photo;
    data["birthday"] = birthday;
    data["expired"] = expired;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ id: $id, name: $name, gender: $gender, photo: $photo, birthday: $birthday, expired: $expired }';
  }
}
