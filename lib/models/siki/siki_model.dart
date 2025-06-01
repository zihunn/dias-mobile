class SikiModel {
  int? status;
  String? message;
  PaginationData? data;

  SikiModel({this.status, this.message, this.data});

  SikiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? PaginationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['status'] = status;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class PaginationData {
  int? currentPage;
  List<SikiItemData>? items;
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

  PaginationData({
    this.currentPage,
    this.items,
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

  PaginationData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      items =
          (json['data'] as List).map((v) => SikiItemData.fromJson(v)).toList();
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = (json['links'] as List).map((v) => Links.fromJson(v)).toList();
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['current_page'] = currentPage;
    if (items != null) {
      result['data'] = items!.map((v) => v.toJson()).toList();
    }
    result['first_page_url'] = firstPageUrl;
    result['from'] = from;
    result['last_page'] = lastPage;
    result['last_page_url'] = lastPageUrl;
    if (links != null) {
      result['links'] = links!.map((v) => v.toJson()).toList();
    }
    result['next_page_url'] = nextPageUrl;
    result['path'] = path;
    result['per_page'] = perPage;
    result['prev_page_url'] = prevPageUrl;
    result['to'] = to;
    result['total'] = total;
    return result;
  }
}

class SikiItemData {
  int? id;
  String? nama;
  int? kodeSikiId;
  String? definisi;
  KodeSiki? kodeSiki;

  SikiItemData(
      {this.id, this.nama, this.kodeSikiId, this.definisi, this.kodeSiki});

  SikiItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kodeSikiId = json['kode_siki_id'];
    definisi = json['definisi'];
    kodeSiki =
        json['kode_siki'] != null ? KodeSiki.fromJson(json['kode_siki']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['nama'] = nama;
    result['kode_siki_id'] = kodeSikiId;
    result['definisi'] = definisi;
    if (kodeSiki != null) {
      result['kode_siki'] = kodeSiki!.toJson();
    }
    return result;
  }
}

class KodeSiki {
  int? id;
  int? idSdki;
  String? kodeSiki;

  KodeSiki({this.id, this.idSdki, this.kodeSiki});

  KodeSiki.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSdki = json['id_sdki'];
    kodeSiki = json['kode_siki'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['id_sdki'] = idSdki;
    result['kode_siki'] = kodeSiki;
    return result;
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
    final Map<String, dynamic> result = {};
    result['url'] = url;
    result['label'] = label;
    result['active'] = active;
    return result;
  }
}
