class AnnualHerbicideModel {
  List<FindAllTableDataAnnualHerbicide>? findAllTableData;

  AnnualHerbicideModel({this.findAllTableData});

  AnnualHerbicideModel.fromJson(Map<String, dynamic> json) {
    if (json['findAllTableData'] != null) {
      findAllTableData = <FindAllTableDataAnnualHerbicide>[];
      json['findAllTableData'].forEach((v) {
        findAllTableData!.add(new FindAllTableDataAnnualHerbicide.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.findAllTableData != null) {
      data['findAllTableData'] =
          this.findAllTableData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindAllTableDataAnnualHerbicide {
  String? jobno;
  String? name;
  String? type;
  String? lat;
  String? lon;
  String? gallon;
  String? status;
  String? supervisorNotes;
  String? generalForemanNotes;
  String? createdBy;
  String? year;
  String? area;
  int? id;
  String? geometry;
  String? createDtm;

  FindAllTableDataAnnualHerbicide(
      {this.jobno,
      this.name,
      this.type,
      this.lat,
      this.lon,
      this.gallon,
      this.status,
      this.supervisorNotes,
      this.generalForemanNotes,
      this.createdBy,
      this.year,
      this.area,
      this.id,
      this.geometry,
      this.createDtm});

  FindAllTableDataAnnualHerbicide.fromJson(Map<String, dynamic> json) {
    jobno = json['jobno']??'';
    name = json['name']??'';
    type = json['type']??'';
    lat = json['lat']??'';
    lon = json['lon']??'';
    gallon = json['gallon']??'';
    status = json['status']??'';
    supervisorNotes = json['supervisor_notes']??'';
    generalForemanNotes = json['general_foreman_notes']??'';
    createdBy = json['created_by']??'';
    year = json['year']??'';
    area = json['area']??'';
    id = json['id']??0;
    geometry = json['geometry']??'';
    createDtm = json['create_dtm']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobno'] = this.jobno;
    data['name'] = this.name;
    data['type'] = this.type;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['gallon'] = this.gallon;
    data['status'] = this.status;
    data['supervisor_notes'] = this.supervisorNotes;
    data['general_foreman_notes'] = this.generalForemanNotes;
    data['created_by'] = this.createdBy;
    data['year'] = this.year;
    data['area'] = this.area;
    data['id'] = this.id;
    data['geometry'] = this.geometry;
    data['create_dtm'] = this.createDtm;
    return data;
  }
}
