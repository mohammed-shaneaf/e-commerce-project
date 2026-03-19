import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../features/add_product/presentation/pages/add_product_page.dart';

import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/home/presentation/cubits/home_cubit.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/product_details/presentation/pages/product_details_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => GetIt.I<HomeCubit>(),
            child: const HomePage(),
          ),
        ),
      ),
      GoRoute(
        path: '/product/:id',
        name: 'product-details',
        pageBuilder: (context, state) {
          final productId = int.parse(state.pathParameters['id']!);
          return MaterialPage(
            key: state.pageKey,
            child: ProductDetailsPage(productId: productId),
          );
        },
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const CartPage()),
      ),
      GoRoute(
        path: '/add-product',
        name: 'add-product',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const AddProductPage()),
      ),
    ],
  );
}
