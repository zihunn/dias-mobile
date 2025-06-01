// class DetailSdkiAll {
//   int? status;
//   String? message;
//   DataSdki? dataSdki;

//   DetailSdkiAll({this.status, this.message, this.dataSdki});

//   DetailSdkiAll.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     dataSdki =
//         json['data_sdki'] != null ? DataSdki.fromJson(json['data_sdki']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['status'] = status;
//     data['message'] = message;
//     if (dataSdki != null) {
//       data['data_sdki'] = dataSdki!.toJson();
//     }
//     return data;
//   }
// }

// class DataSdki {
//   int? id;
//   String? nama;
//   String? kode;
//   String? definisi;
//   String? kategori;
//   String? subkategori;
//   List<Penyebab?>? penyebab;
//   List<Mayor?>? mayor;
//   List<Minor>? minor;
//   List<KondisiTerkait?>? kondisiTerkait;
//   List<KodeSlki?>? kodeSlki;
//   List<Siki?>? siki;
//   List<Slki?>? slki;

//   DataSdki(
//       {this.id,
//       this.nama,
//       this.kode,
//       this.definisi,
//       this.kategori,
//       this.subkategori,
//       this.penyebab,
//       this.mayor,
//       this.minor,
//       this.kondisiTerkait,
//       this.kodeSlki,
//       this.siki,
//       this.slki});

//   DataSdki.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nama = json['nama'];
//     kode = json['kode'];
//     definisi = json['definisi'];
//     kategori = json['kategori'];
//     subkategori = json['subkategori'];
//     if (json['penyebab'] != null) {
//       penyebab = <Penyebab?>[];
//       json['penyebab'].forEach((v) {
//         penyebab!.add(Penyebab.fromJson(v));
//       });
//     }
//     if (json['mayor'] != null) {
//       mayor = <Mayor?>[];
//       json['mayor'].forEach((v) {
//         mayor!.add(Mayor.fromJson(v));
//       });
//     }
//     if (json['minor'] != null) {
//       minor = <Minor>[];
//       json['minor'].forEach((v) {
//         minor!.add(Minor.fromJson(v));
//       });
//     }
//     if (json['kondisi_terkait'] != null) {
//       kondisiTerkait = <KondisiTerkait?>[];
//       json['kondisi_terkait'].forEach((v) {
//         kondisiTerkait!.add(KondisiTerkait.fromJson(v));
//       });
//     }
//     if (json['kode_slki'] != null) {
//       kodeSlki = <KodeSlki?>[];
//       json['kode_slki'].forEach((v) {
//         kodeSlki!.add(KodeSlki.fromJson(v));
//       });
//     }
//     if (json['siki'] != null) {
//       siki = <Siki?>[];
//       json['siki'].forEach((v) {
//         siki!.add(Siki.fromJson(v));
//       });
//     }
//     if (json['slki'] != null) {
//       slki = <Slki?>[];
//       json['slki'].forEach((v) {
//         slki!.add(Slki.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['nama'] = nama;
//     data['kode'] = kode;
//     data['definisi'] = definisi;
//     data['kategori'] = kategori;
//     data['subkategori'] = subkategori;
//     if (penyebab != null) {
//       data['penyebab'] = penyebab!.map((v) => v?.toJson()).toList();
//     }
//     if (mayor != null) {
//       data['mayor'] = mayor!.map((v) => v?.toJson()).toList();
//     }
//     if (minor != null) {
//       data['minor'] = minor!.map((v) => v.toJson()).toList();
//     }
//     if (kondisiTerkait != null) {
//       data['kondisi_terkait'] =
//           kondisiTerkait!.map((v) => v?.toJson()).toList();
//     }
//     if (kodeSlki != null) {
//       data['kode_slki'] = kodeSlki!.map((v) => v?.toJson()).toList();
//     }
//     if (siki != null) {
//       data['siki'] = siki!.map((v) => v?.toJson()).toList();
//     }
//     if (slki != null) {
//       data['slki'] = slki!.map((v) => v?.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Mayor {
//   int? id;
//   int? idSdki;
//   String? kategori;
//   String? desc;

//   Mayor({this.id, this.idSdki, this.kategori, this.desc});

//   Mayor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idSdki = json['id_sdki'];
//     kategori = json['kategori'];
//     desc = json['desc'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['id_sdki'] = idSdki;
//     data['kategori'] = kategori;
//     data['desc'] = desc;
//     return data;
//   }
// }

// class Minor {
//   int? id;
//   int? idSdki;
//   String? kategori;
//   String? desc;

//   Minor({this.id, this.idSdki, this.kategori, this.desc});

//   Minor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idSdki = json['id_sdki'];
//     kategori = json['kategori'];
//     desc = json['desc'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['id_sdki'] = idSdki;
//     data['kategori'] = kategori;
//     data['desc'] = desc;
//     return data;
//   }
// }

// class Penyebab {
//   int? id;
//   int? idSdki;
//   String? kategori;
//   String? desc;

//   Penyebab({this.id, this.idSdki, this.kategori, this.desc});

//   Penyebab.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idSdki = json['id_sdki'];
//     kategori = json['kategori'];
//     desc = json['desc'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['id_sdki'] = idSdki;
//     data['kategori'] = kategori;
//     data['desc'] = desc;
//     return data;
//   }
// }

// class KondisiTerkait {
//   int? id;
//   int? idSdki;
//   String? desc;

//   KondisiTerkait({this.id, this.idSdki, this.desc});

//   KondisiTerkait.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idSdki = json['id_sdki'];
//     desc = json['desc'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['id_sdki'] = idSdki;
//     data['desc'] = desc;
//     return data;
//   }
// }

// class KodeSlki {
//   int? id;
//   int? idSdki;
//   String? kodeSlki;

//   KodeSlki({this.id, this.idSdki, this.kodeSlki});

//   KodeSlki.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idSdki = json['id_sdki'];
//     kodeSlki = json['kode_slki'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['id_sdki'] = idSdki;
//     data['kode_slki'] = kodeSlki;
//     return data;
//   }
// }

// class Siki {
//   int? id;
//   String? nama;
//   int? kodeSikiId;
//   String? definisi;
//   List<Tindakan?>? tindakan;

//   Siki({this.id, this.nama, this.kodeSikiId, this.definisi, this.tindakan});

//   Siki.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nama = json['nama'];
//     kodeSikiId = json['kode_siki_id'];
//     definisi = json['definisi'];
//     if (json['tindakan'] != null) {
//       tindakan = <Tindakan?>[];
//       json['tindakan'].forEach((v) {
//         tindakan!.add(Tindakan.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['nama'] = nama;
//     data['kode_siki_id'] = kodeSikiId;
//     data['definisi'] = definisi;
//     if (tindakan != null) {
//       data['tindakan'] = tindakan!.map((v) => v?.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Tindakan {
//   int? id;
//   int? idSiki;
//   String? desc;
//   String? category;

//   Tindakan({this.id, this.idSiki, this.desc, this.category});

//   Tindakan.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idSiki = json['id_siki'];
//     desc = json['desc'];
//     category = json['category'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['id_siki'] = idSiki;
//     data['desc'] = desc;
//     data['category'] = category;
//     return data;
//   }
// }

// class Slki {
//   int? id;
//   String? nama;
//   int? kodeSlkiId;
//   String? desc;
//   List<Kriteria?>? kriteria;

//   Slki({this.id, this.nama, this.kodeSlkiId, this.desc, this.kriteria});

//   Slki.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nama = json['nama'];
//     kodeSlkiId = json['kode_slki_id'];
//     desc = json['desc'];
//     if (json['kriteria'] != null) {
//       kriteria = <Kriteria?>[];
//       json['kriteria'].forEach((v) {
//         kriteria!.add(Kriteria.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['nama'] = nama;
//     data['kode_slki_id'] = kodeSlkiId;
//     data['desc'] = desc;
//     if (kriteria != null) {
//       data['kriteria'] = kriteria!.map((v) => v?.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Kriteria {
//   int? id;
//   int? idSlki;
//   String? desc;
//   String? category;

//   Kriteria({this.id, this.idSlki, this.desc, this.category});

//   Kriteria.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idSlki = json['id_slki'];
//     desc = json['desc'];
//     category = json['category'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['id_slki'] = idSlki;
//     data['desc'] = desc;
//     data['category'] = category;
//     return data;
//   }
// }
