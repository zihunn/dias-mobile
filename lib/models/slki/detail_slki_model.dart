class DetailSlki {
  int? status;
  String? message;
  Data? data;

  DetailSlki({this.status, this.message, this.data});

  DetailSlki.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      status = json['status'];
      message = json['message'];
      data = json['data'] != null ? Data.fromJson(json['data']) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  SlkiData? slkiData;
  List<SlkiKriteria>? slkiKriteria;

  Data({this.slkiData, this.slkiKriteria});

  Data.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      slkiData = json['slki_data'] != null
          ? SlkiData.fromJson(json['slki_data'])
          : null;
      if (json['slki_kriteria'] != null) {
        slkiKriteria = <SlkiKriteria>[];
        json['slki_kriteria'].forEach((v) {
          slkiKriteria!.add(SlkiKriteria.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slkiData != null) {
      data['slki_data'] = slkiData?.toJson();
    }
    if (slkiKriteria != null) {
      data['slki_kriteria'] = slkiKriteria?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SlkiData {
  int? id;
  int? idSdki;
  String? kodeSlki;
  List<Slki>? slki;

  SlkiData({this.id, this.idSdki, this.kodeSlki, this.slki});

  SlkiData.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      idSdki = json['id_sdki'];
      kodeSlki = json['kode_slki'];
      if (json['slki'] != null) {
        slki = <Slki>[];
        json['slki'].forEach((v) {
          slki!.add(Slki.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_sdki'] = idSdki;
    data['kode_slki'] = kodeSlki;
    if (slki != null) {
      data['slki'] = slki?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slki {
  int? id;
  String? nama;
  String? definisi;
  String? desc;
  int? kodeSlkiId;

  Slki({this.id, this.nama, this.definisi, this.desc, this.kodeSlkiId});

  Slki.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      nama = json['nama'];
      definisi = json['definisi'];
      desc = json['desc'];
      kodeSlkiId = json['kode_slki_id'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['definisi'] = definisi;
    data['desc'] = desc;
    data['kode_slki_id'] = kodeSlkiId;
    return data;
  }
}

class SlkiKriteria {
  int? id;
  int? idSlki;
  String? desc;

  SlkiKriteria({this.id, this.idSlki, this.desc});

  SlkiKriteria.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      idSlki = json['id_slki'];
      desc = json['desc'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_slki'] = idSlki;
    data['desc'] = desc;
    return data;
  }
}
