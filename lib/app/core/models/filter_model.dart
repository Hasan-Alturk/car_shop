class FilterModel {
  String? brand;
  String? yom;
  String? startPrice;
  String? endPrice;
  String? model;
  List<String>? categories;
  FilterModel({
    this.brand,
    this.yom,
    this.startPrice,
    this.endPrice,
    this.model,
    this.categories,
  });
  @override
  String toString() {
    return "brand:$brand ,yom:$yom ,startPrice:$startPrice endPrice:$endPrice model:$model categories: $categories";
  }
}
