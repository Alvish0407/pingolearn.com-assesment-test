import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_sizes.dart';
import '../../../utils/app_theme.dart';
import '../domain/product_model.dart';
import 'home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<HomeProvider>().products;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('e-Shop'),
        backgroundColor: context.theme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: context.theme.colorScheme.surface,
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await context.read<HomeProvider>().getProducts();
        },
        child: StreamBuilder(
          stream: FirebaseRemoteConfig.instance.onConfigUpdated,
          builder: (context, snapshot) {
            return GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final showDiscountedPrice = context.watch<HomeProvider>().showDiscountedPrice;
    final price = product.price;
    final discountPrice = price - (price * product.discountPercentage / 100);
    final discountPercentage = product.discountPercentage;

    return Card(
      color: context.theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: CachedNetworkImage(
                imageUrl: product.thumbnail.toString(),
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: context.theme.textTheme.labelMedium?.bold,
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 8),
                if (!showDiscountedPrice)
                  Text(
                    '\$$price',
                    style: context.theme.textTheme.labelSmall,
                  ),
                if (showDiscountedPrice)
                  Row(
                    children: [
                      Text(
                        '\$$price',
                        style: context.theme.textTheme.labelSmall?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: context.theme.extension<AppColors>()?.onSurface2,
                          decorationColor: context.theme.extension<AppColors>()?.onSurface2,
                        ),
                      ),
                      gapW12,
                      Text(
                        '\$${discountPrice.toStringAsFixed(2)}',
                        style: context.theme.textTheme.labelSmall,
                      ),
                      gapW12,
                      Text(
                        '$discountPercentage% off',
                        style: context.theme.textTheme.labelSmall?.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
