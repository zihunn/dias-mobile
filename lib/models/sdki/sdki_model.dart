class SdkiModel {
  int? status;
  String? message;
  Data? data;

  SdkiModel({this.status, this.message, this.data});

  SdkiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['status'] = status;
    dataMap['message'] = message;
    if (data != null) {
      dataMap['data'] = data!.toJson();
    }
    return dataMap;
  }
}

class Data {
  int? currentPage;
  List<SdkiDetail>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SdkiDetail>[];
      json['data'].forEach((v) {
        data!.add(SdkiDetail.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['current_page'] = currentPage;
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    dataMap['first_page_url'] = firstPageUrl;
    dataMap['from'] = from;
    dataMap['last_page'] = lastPage;
    dataMap['last_page_url'] = lastPageUrl;
    if (links != null) {
      dataMap['links'] = links!.map((v) => v.toJson()).toList();
    }
    dataMap['next_page_url'] = nextPageUrl;
    dataMap['path'] = path;
    dataMap['per_page'] = perPage;
    dataMap['prev_page_url'] = prevPageUrl;
    dataMap['to'] = to;
    dataMap['total'] = total;
    return dataMap;
  }
}

class SdkiDetail {
  int? id;
  String? nama;
  String? kode;
  String? definisi;
  String? kategori;
  String? subkategori;

  SdkiDetail(
      {this.id,
      this.nama,
      this.kode,
      this.definisi,
      this.kategori,
      this.subkategori});

  SdkiDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kode = json['kode'];
    definisi = json['definisi'];
    kategori = json['kategori'];
    subkategori = json['subkategori'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['id'] = id;
    dataMap['nama'] = nama;
    dataMap['kode'] = kode;
    dataMap['definisi'] = definisi;
    dataMap['kategori'] = kategori;
    dataMap['subkategori'] = subkategori;
    return dataMap;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['url'] = url;
    dataMap['label'] = label;
    dataMap['active'] = active;
    return dataMap;
  }
}
