
class Experience {
    List<ExperienceResult>? results;

    Experience({this.results});

    Experience.fromJson(Map<String, dynamic> json) {
        results = json["results"] == null ? null : (json["results"] as List).map((e) => ExperienceResult.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if(results != null) {
            data["results"] = results?.map((e) => e.toJson()).toList();
        }
        return data;
    }
}

class ExperienceResult {
    int? id;
    String? status;
    String? jobTitle;
    String? companyName;
    String? industry;

    ExperienceResult({this.id, this.status, this.jobTitle, this.companyName, this.industry});

    ExperienceResult.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        status = json["status"];
        jobTitle = json["job_title"];
        companyName = json["company_name"];
        industry = json["industry"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["status"] = status;
        data["job_title"] = jobTitle;
        data["company_name"] = companyName;
        data["industry"] = industry;
        return data;
    }
}