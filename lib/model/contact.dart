class Contact {
  List<ContactResult>? results;

  Contact({this.results});

  Contact.fromJson(Map<String, dynamic> json) {
    results = json["results"] == null
        ? null
        : (json["results"] as List)
            .map((e) => ContactResult.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data["results"] = results?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ContactResult {
  int? id;
  String? email;
  String? phone;

  ContactResult({this.id, this.email, this.phone});

  ContactResult.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["email"] = email;
    data["phone"] = phone;
    return data;
  }
}
