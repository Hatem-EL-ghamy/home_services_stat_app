class Categories {
  final String? id;
  final String? name;
  final String? path;

  Categories({
    this.id,
    this.name,
    this.path,
  });
}

class CategoryModel {
  final List<Categories>? categories;

  CategoryModel({
    this.categories,
  });
}

