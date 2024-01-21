class Catalog {
  Catalog({
    required this.catalog,
  });
  late final List<Catalog> catalog;

  Catalog.fromJson(Map<String, dynamic> json) {
    catalog =
        List.from(json['Catalog']).map((e) => Catalog.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Catalog'] = catalog.map((e) => e.toJson()).toList();
    return _data;
  }
}
