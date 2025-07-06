import 'package:blinknews/model/category_model.dart';

List<CategoryModel> getCategory() {
  List<CategoryModel> categroy = [];

  CategoryModel categoryModel = CategoryModel();
  // categoryModel.categoryname = "business";
  // categoryModel.image = "images/business.jpg";
  // categroy.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryname = "entertainment";
  categoryModel.image = "images/entertainment.jpg";
  categroy.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryname = "general";
  categoryModel.image = "images/general.jpg";
  categroy.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryname = "health";
  categoryModel.image = "images/health.jpg";
  categroy.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryname = "science";
  categoryModel.image = "images/science.jpg";
  categroy.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryname = "sports";
  categoryModel.image = "images/sport.jpg";
  categroy.add(categoryModel);

  return categroy;
}
