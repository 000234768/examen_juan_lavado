class Category {
  final int categoryId;
  final String categoryName;
  final String categoryState;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      categoryState: json['category_state'],
    );
  }

  @override
  String toString() {
    return 'Category{categoryId: $categoryId, categoryName: $categoryName, categoryState: $categoryState}';
  }
}
