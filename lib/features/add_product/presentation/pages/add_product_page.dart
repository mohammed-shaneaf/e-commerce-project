import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../cubits/add_product_cubit.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  String _selectedCategory = 'electronics';

  final _categories = [
    'electronics',
    'jewelery',
    "men's clothing",
    "women's clothing",
  ];

  static const _categoryIcons = <String, IconData>{
    'electronics': Icons.devices_rounded,
    'jewelery': Icons.diamond_rounded,
    "men's clothing": Icons.male_rounded,
    "women's clothing": Icons.female_rounded,
  };

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => GetIt.I<AddProductCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AddProductCubit, AddProductState>(
            listener: (context, state) {
              if (state is AddProductSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(state.message),
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppTheme.success,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
                context.pop();
              }
              if (state is AddProductFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(state.errMessage)),
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppTheme.secondaryAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppTheme.darkCard
                                  : AppTheme.surfaceMedium,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Add Product',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            color: isDark
                                ? AppTheme.darkTextPrimary
                                : AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Form
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            _FieldLabel(
                              label: 'Product Title',
                              icon: Icons.title_rounded,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                hintText: 'Enter product title',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Title is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 22),

                            // Price
                            _FieldLabel(
                              label: 'Price',
                              icon: Icons.attach_money_rounded,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _priceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: const InputDecoration(
                                hintText: 'Enter price',
                                prefixText: '\$ ',
                                prefixStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primaryAccent,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Price is required';
                                }
                                if (double.tryParse(value.trim()) == null) {
                                  return 'Enter a valid price';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 22),

                            // Category
                            _FieldLabel(
                              label: 'Category',
                              icon: Icons.category_rounded,
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: _categories.map((category) {
                                final isSelected =
                                    category == _selectedCategory;
                                final icon =
                                    _categoryIcons[category] ??
                                    Icons.category_rounded;
                                return GestureDetector(
                                  onTap: () => setState(
                                    () => _selectedCategory = category,
                                  ),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: isSelected
                                          ? const LinearGradient(
                                              colors: [
                                                AppTheme.primaryAccent,
                                                Color(0xFF8B83FF),
                                              ],
                                            )
                                          : null,
                                      color: isSelected
                                          ? null
                                          : (isDark
                                                ? AppTheme.darkCard
                                                : AppTheme.surfaceMedium),
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: AppTheme.primaryAccent
                                                    .withValues(alpha: 0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          icon,
                                          size: 18,
                                          color: isSelected
                                              ? Colors.white
                                              : AppTheme.textSecondary,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          category[0].toUpperCase() +
                                              category.substring(1),
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: isSelected
                                                ? FontWeight.w700
                                                : FontWeight.w500,
                                            color: isSelected
                                                ? Colors.white
                                                : (isDark
                                                      ? AppTheme
                                                            .darkTextSecondary
                                                      : AppTheme.textSecondary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 22),

                            // Description
                            _FieldLabel(
                              label: 'Description',
                              icon: Icons.description_rounded,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                hintText: 'Enter product description',
                                alignLabelWithHint: true,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Description is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 22),

                            // Image URL
                            _FieldLabel(
                              label: 'Image URL',
                              icon: Icons.image_rounded,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _imageController,
                              decoration: const InputDecoration(
                                hintText: 'https://example.com/image.jpg',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Image URL is required';
                                }
                                final uri = Uri.tryParse(value.trim());
                                if (uri == null || !uri.hasScheme) {
                                  return 'Enter a valid URL';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 36),

                            // Submit Button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: state is AddProductLoading
                                      ? null
                                      : const LinearGradient(
                                          colors: [
                                            AppTheme.primaryAccent,
                                            Color(0xFF8B83FF),
                                          ],
                                        ),
                                  color: state is AddProductLoading
                                      ? AppTheme.textMuted
                                      : null,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: state is AddProductLoading
                                      ? []
                                      : [
                                          BoxShadow(
                                            color: AppTheme.primaryAccent
                                                .withValues(alpha: 0.4),
                                            blurRadius: 16,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(18),
                                    onTap: state is AddProductLoading
                                        ? null
                                        : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<AddProductCubit>()
                                                  .addProduct(
                                                    title: _titleController.text
                                                        .trim(),
                                                    price: double.parse(
                                                      _priceController.text
                                                          .trim(),
                                                    ),
                                                    description:
                                                        _descriptionController
                                                            .text
                                                            .trim(),
                                                    category: _selectedCategory,
                                                    image: _imageController.text
                                                        .trim(),
                                                  );
                                            }
                                          },
                                    child: Center(
                                      child: state is AddProductLoading
                                          ? const SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_rounded,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Add Product',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    letterSpacing: 0.3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final IconData icon;

  const _FieldLabel({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.primaryAccent),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
