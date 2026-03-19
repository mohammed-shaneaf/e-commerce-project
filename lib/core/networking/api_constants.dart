class ApiConstants {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Products
  static const String products = '/products';
  static const String productById = '/products/{id}';
  static const String categories = '/products/categories';
  static const String productsByCategory = '/products/category/{category}';

  // Carts
  static const String carts = '/carts';
  static const String cartById = '/carts/{id}';

  // Auth
  static const String login = '/auth/login';
}
