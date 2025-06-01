class DetailSikiModel {
  int? status;
  String? message;
  Data? data;

  DetailSikiModel({this.status, this.message, this.data});

  DetailSikiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  SikiData? sikiData;
  List<SikiKriteria>? sikiKriteria;

  Data({this.sikiData, this.sikiKriteria});

  Data.fromJson(Map<String, dynamic> json) {
    sikiData = json['siki_data'] != null
        ? SikiData.fromJson(json['siki_data'])
        : null;
    if (json['siki_kriteria'] != null) {
      sikiKriteria = <SikiKriteria>[];
      json['siki_kriteria'].forEach((v) {
        sikiKriteria!.add(SikiKriteria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sikiData != null) {
      data['siki_data'] = sikiData!.toJson();
    }
    if (sikiKriteria != null) {
      data['siki_kriteria'] =
          sikiKriteria!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SikiData {
  int? id;
  int? idSdki;
  String? kodeSiki;
  List<Siki>? siki;

  SikiData({this.id, this.idSdki, this.kodeSiki, this.siki});

  SikiData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSdki = json['id_sdki'];
    kodeSiki = json['kode_siki'];
    if (json['siki'] != null) {
      siki = <Siki>[];
      json['siki'].forEach((v) {
        siki!.add(Siki.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_sdki'] = idSdki;
    data['kode_siki'] = kodeSiki;
    if (siki != null) {
      data['siki'] = siki!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Siki {
  int? id;
  String? nama;
  int? kodeSikiId;
  String? definisi;

  Siki({this.id, this.nama, this.kodeSikiId, this.definisi});

  Siki.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kodeSikiId = json['kode_siki_id'];
    definisi = json['definisi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['kode_siki_id'] = kodeSikiId;
    data['definisi'] = definisi;
    return data;
  }
}

class SikiKriteria {
  int? id;
  int? idSiki;
  String? category;
  String? desc;

  SikiKriteria({this.id, this.idSiki, this.category, this.desc});

  SikiKriteria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSiki = json['id_siki'];
    category = json['category'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_siki'] = idSiki;
    data['category'] = category;
    data['desc'] = desc;
    return data;
  }
}
