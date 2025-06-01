class DetailSdkiModel {
  int? status;
  String? message;
  int? length;
  DataSdki? dataSdki;

  DetailSdkiModel({this.status, this.message, this.dataSdki, this.length});

  DetailSdkiModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      status = json['status'];
      message = json['message'];
      length = json['length'];
      dataSdki = json['data_sdki'] != null
          ? DataSdki.fromJson(json['data_sdki'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['length'] = length;
    if (dataSdki != null) {
      data['data_sdki'] = dataSdki!.toJson();
    }
    return data;
  }
}

class DataSdki {
  int? id;
  String? nama;
  String? kode;
  String? definisi;
  String? kategori;
  String? subkategori;
  List<Penyebab>? penyebab;
  List<Mayor>? mayor;
  List<Minor>? minor;
  List<KondisisTerkait>? kondisisTerkait;

  DataSdki({
    this.id,
    this.nama,
    this.kode,
    this.definisi,
    this.kategori,
    this.subkategori,
    this.penyebab,
    this.mayor,
    this.minor,
    this.kondisisTerkait,
  });

  DataSdki.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      nama = json['nama'];
      kode = json['kode'];
      definisi = json['definisi'];
      kategori = json['kategori'];
      subkategori = json['subkategori'];
      if (json['penyebab'] != null) {
        penyebab = <Penyebab>[];
        json['penyebab'].forEach((v) {
          penyebab!.add(Penyebab.fromJson(v));
        });
      }
      if (json['mayor'] != null) {
        mayor = <Mayor>[];
        json['mayor'].forEach((v) {
          mayor!.add(Mayor.fromJson(v));
        });
      }
      if (json['minor'] != null) {
        minor = <Minor>[];
        json['minor'].forEach((v) {
          minor!.add(Minor.fromJson(v));
        });
      }
      if (json['kondisis_terkait'] != null) {
        kondisisTerkait = <KondisisTerkait>[];
        json['kondisis_terkait'].forEach((v) {
          kondisisTerkait!.add(KondisisTerkait.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['kode'] = kode;
    data['definisi'] = definisi;
    data['kategori'] = kategori;
    data['subkategori'] = subkategori;
    if (penyebab != null) {
      data['penyebab'] = penyebab!.map((v) => v.toJson()).toList();
    }
    if (mayor != null) {
      data['mayor'] = mayor!.map((v) => v.toJson()).toList();
    }
    if (minor != null) {
      data['minor'] = minor!.map((v) => v.toJson()).toList();
    }
    if (kondisisTerkait != null) {
      data['kondisis_terkait'] =
          kondisisTerkait!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Penyebab {
  int? id;
  int? idSdki;
  String? kategori;
  String? desc;

  Penyebab({this.id, this.idSdki, this.kategori, this.desc});

  Penyebab.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      idSdki = json['id_sdki'];
      kategori = json['kategori'];
      desc = json['desc'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_sdki'] = idSdki;
    data['kategori'] = kategori;
    data['desc'] = desc;
    return data;
  }
}

class KondisisTerkait {
  int? id;
  int? idSdki;
  String? desc;

  KondisisTerkait({this.id, this.idSdki, this.desc});

  KondisisTerkait.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      idSdki = json['id_sdki'];
      desc = json['desc'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_sdki'] = idSdki;
    data['desc'] = desc;
    return data;
  }
}

class Mayor {
  int? id;
  String? desc;

  Mayor({this.id, this.desc});

  Mayor.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      desc = json['desc'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['desc'] = desc;
    return data;
  }
}

class Minor {
  int? id;
  String? desc;

  Minor({this.id, this.desc});

  Minor.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      desc = json['desc'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['desc'] = desc;
    return data;
  }
}
