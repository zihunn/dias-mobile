class SearchModels {
  int? status;
  String? message;
  List<Data>? data;

  SearchModels({this.status, this.message, this.data});

  SearchModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? nama;
  String? kode;
  String? definisi;
  String? kategori;
  String? subkategori;

  Data(
      {this.id,
      this.nama,
      this.kode,
      this.definisi,
      this.kategori,
      this.subkategori});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kode = json['kode'];
    definisi = json['definisi'];
    kategori = json['kategori'];
    subkategori = json['subkategori'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['kode'] = this.kode;
    data['definisi'] = this.definisi;
    data['kategori'] = this.kategori;
    data['subkategori'] = this.subkategori;
    return data;
  }
}
