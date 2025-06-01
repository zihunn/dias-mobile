class SlkiModel {
  int? status;
  String? message;
  PaginationData? data;

  SlkiModel({this.status, this.message, this.data});

  SlkiModel.fromJson(Map<String, dynamic> json) {
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
  List<SlkiItemData>? items;
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
          (json['data'] as List).map((v) => SlkiItemData.fromJson(v)).toList();
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    links = json['links'] != null
        ? (json['links'] as List).map((v) => Links.fromJson(v)).toList()
        : null;
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

class SlkiItemData {
  int? id;
  String? nama;
  String? definisi;
  String? desc;
  int? kodeSlkiId;
  KodeSlki? kodeSlki;

  SlkiItemData({
    this.id,
    this.nama,
    this.definisi,
    this.desc,
    this.kodeSlkiId,
    this.kodeSlki,
  });

  SlkiItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    definisi = json['definisi'];
    desc = json['desc'];
    kodeSlkiId = json['kode_slki_id'];
    kodeSlki =
        json['kode_slki'] != null ? KodeSlki.fromJson(json['kode_slki']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['nama'] = nama;
    result['definisi'] = definisi;
    result['desc'] = desc;
    result['kode_slki_id'] = kodeSlkiId;
    if (kodeSlki != null) {
      result['kode_slki'] = kodeSlki!.toJson();
    }
    return result;
  }
}

class KodeSlki {
  int? id;
  int? idSdki;
  String? kodeSlki;

  KodeSlki({this.id, this.idSdki, this.kodeSlki});

  KodeSlki.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSdki = json['id_sdki'];
    kodeSlki = json['kode_slki'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['id_sdki'] = idSdki;
    result['kode_slki'] = kodeSlki;
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
