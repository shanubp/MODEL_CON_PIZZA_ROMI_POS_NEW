class CutRecordModel{
  String? cutId;
  String? imageUrl;
  String? name;
  List<String>? search;

//<editor-fold desc="Data Methods">
  CutRecordModel({
    this.cutId,
    this.imageUrl,
    this.name,
    this.search,
  });

  CutRecordModel copyWith({
    String? cutId,
    String? imageUrl,
    String? name,
    List<String>? search,
  }) {
    return CutRecordModel(
      cutId: cutId ?? this.cutId,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      search: search ?? this.search,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cutId': this.cutId,
      'imageUrl': this.imageUrl,
      'name': this.name,
      'search': this.search,
    };
  }

  factory CutRecordModel.fromMap(Map<String, dynamic> map) {
    return CutRecordModel(
      cutId: map['cutId'] ??'',
      imageUrl: map['imageUrl'] ??'',
      name: map['name'] ??'',
      search: map['search'] ??[],
    );
  }

//</editor-fold>
}