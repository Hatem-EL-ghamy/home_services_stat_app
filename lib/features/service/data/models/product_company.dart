class Companies {
  final String? id;
  final String? name;
  final String? image;
  final String? description;
  final String? path;
  final String? price;
  final String? nationality;
  final String? numbers;

  Companies({
    this.id,
    this.name,
    this.image,
    this.description,
    this.path,
    this.price,
    this.nationality,
    this.numbers,
  });
}

class ProductCompanyModel {
  final List<Companies>? companies;

  ProductCompanyModel({
    this.companies,
  });
}

