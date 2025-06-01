class ApiResponse {
  int? status;
  String? message;
  List<Data>? data;

  ApiResponse({this.status, this.message, this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
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
    data['status'] = status;
    data['message'] = message;
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
  List<Penyebab>? penyebab;
  List<Mayor>? mayor;
  List<Minor>? minor;
  List<KondisisTerkait>? kondisisTerkait;
  List<KodeSlki>? kodeSlki;
  List<KodeSiki>? kodeSiki;
  List<Siki>? siki;
  List<Slki>? slki;

  Data(
      {this.id,
      this.nama,
      this.kode,
      this.definisi,
      this.kategori,
      this.subkategori,
      this.penyebab,
      this.mayor,
      this.minor,
      this.kondisisTerkait,
      this.kodeSlki,
      this.kodeSiki,
      this.siki,
      this.slki});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json['kode_slki'] != null) {
      kodeSlki = <KodeSlki>[];
      json['kode_slki'].forEach((v) {
        kodeSlki!.add(KodeSlki.fromJson(v));
      });
    }
    if (json['kode_siki'] != null) {
      kodeSiki = <KodeSiki>[];
      json['kode_siki'].forEach((v) {
        kodeSiki!.add(KodeSiki.fromJson(v));
      });
    }
    if (json['siki'] != null) {
      siki = <Siki>[];
      json['siki'].forEach((v) {
        siki!.add(Siki.fromJson(v));
      });
    }
    if (json['slki'] != null) {
      slki = <Slki>[];
      json['slki'].forEach((v) {
        slki!.add(Slki.fromJson(v));
      });
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
    if (kodeSlki != null) {
      data['kode_slki'] = kodeSlki!.map((v) => v.toJson()).toList();
    }
    if (kodeSiki != null) {
      data['kode_siki'] = kodeSiki!.map((v) => v.toJson()).toList();
    }
    if (siki != null) {
      data['siki'] = siki!.map((v) => v.toJson()).toList();
    }
    if (slki != null) {
      data['slki'] = slki!.map((v) => v.toJson()).toList();
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

  Penyebab.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSdki = json['id_sdki'];
    kategori = json['kategori'];
    desc = json['desc'];
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

class Mayor {
  int? id;
  int? idSdki;
  String? kategori;
  String? desc;

  Mayor({this.id, this.idSdki, this.kategori, this.desc});

  Mayor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSdki = json['id_sdki'];
    kategori = json['kategori'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_sdki': idSdki,
      'kategori': kategori,
      'desc': desc,
    };
  }
}

class Minor {
  int? id;
  int? idSdki;
  String? kategori;
  String? desc;

  Minor({this.id, this.idSdki, this.kategori, this.desc});

  Minor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSdki = json['id_sdki'];
    kategori = json['kategori'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_sdki': idSdki,
      'kategori': kategori,
      'desc': desc,
    };
  }
}

class KondisisTerkait {
  int? id;
  int? idSdki;
  String? desc;

  KondisisTerkait({this.id, this.idSdki, this.desc});

  KondisisTerkait.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSdki = json['id_sdki'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_sdki'] = idSdki;
    data['desc'] = desc;
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_sdki'] = idSdki;
    data['kode_slki'] = kodeSlki;
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_sdki'] = idSdki;
    data['kode_siki'] = kodeSiki;
    return data;
  }
}

class Siki {
  int? id;
  String? nama;
  int? kodeSikiId;
  String? definisi;
  int? laravelThroughKey;
  List<Tindakan>? tindakan;

  Siki(
      {this.id,
      this.nama,
      this.kodeSikiId,
      this.definisi,
      this.laravelThroughKey,
      this.tindakan});

  Siki.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kodeSikiId = json['kode_siki_id'];
    definisi = json['definisi'];
    laravelThroughKey = json['laravel_through_key'];
    if (json['tindakan'] != null) {
      tindakan = <Tindakan>[];
      json['tindakan'].forEach((v) {
        tindakan!.add(Tindakan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['kode_siki_id'] = kodeSikiId;
    data['definisi'] = definisi;
    data['laravel_through_key'] = laravelThroughKey;
    if (tindakan != null) {
      data['tindakan'] = tindakan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tindakan {
  int? id;
  int? idSiki;
  String? category;
  String? desc;

  Tindakan({this.id, this.idSiki, this.category, this.desc});

  Tindakan.fromJson(Map<String, dynamic> json) {
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

class Slki {
  int? id;
  String? nama;
  String? definisi;
  String? desc;
  int? kodeSlkiId;
  int? laravelThroughKey;
  List<Kriteria>? kriteria;

  Slki(
      {this.id,
      this.nama,
      this.definisi,
      this.desc,
      this.kodeSlkiId,
      this.laravelThroughKey,
      this.kriteria});

  Slki.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    definisi = json['definisi'];
    desc = json['desc'];
    kodeSlkiId = json['kode_slki_id'];
    laravelThroughKey = json['laravel_through_key'];
    if (json['kriteria'] != null) {
      kriteria = <Kriteria>[];
      json['kriteria'].forEach((v) {
        kriteria!.add(Kriteria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['definisi'] = definisi;
    data['desc'] = desc;
    data['kode_slki_id'] = kodeSlkiId;
    data['laravel_through_key'] = laravelThroughKey;
    if (kriteria != null) {
      data['kriteria'] = kriteria!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Kriteria {
  int? id;
  int? idSlki;
  String? desc;

  Kriteria({this.id, this.idSlki, this.desc});

  Kriteria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSlki = json['id_slki'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_slki'] = idSlki;
    data['desc'] = desc;
    return data;
  }
}
