
class Address {
    List<AddressResult>? results;

    Address({this.results});

    Address.fromJson(Map<String, dynamic> json) {
        results = json["results"] == null ? null : (json["results"] as List).map((e) => AddressResult.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if(results != null) {
            data["results"] = results?.map((e) => e.toJson()).toList();
        }
        return data;
    }
}

class AddressResult {
    int? id;
    String? address;
    String? city;
    String? state;
    int? zipCode;

    AddressResult({this.id, this.address, this.city, this.state, this.zipCode});

    AddressResult.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        address = json["address"];
        city = json["city"];
        state = json["state"];
        zipCode = json["zip_code"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["address"] = address;
        data["city"] = city;
        data["state"] = state;
        data["zip_code"] = zipCode;
        return data;
    }
}