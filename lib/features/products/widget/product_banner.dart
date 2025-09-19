import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/product_model.dart';

class ProductBanner extends StatelessWidget {
  final Product product;

  const ProductBanner({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: double.infinity,
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(gradient: AppColors.primaryGradient),
            child: const Center(
              child: Icon(
                Icons.image_not_supported,
                size: 64,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}