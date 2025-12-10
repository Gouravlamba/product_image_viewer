import '../models/product_model.dart';
import '../services/api_service.dart';
import '../services/local_data_service.dart';

class ProductRepository {
  final ApiService apiService;
  final LocalDataService localDataService;

  ProductRepository({required this.apiService, required this.localDataService});

  Future<List<Product>> getProducts() async {
    try {
      final remoteData = await apiService.fetchProductList();
      return remoteData
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      final localData = await localDataService.loadLocalProductsJson();
      return localData
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }
}
