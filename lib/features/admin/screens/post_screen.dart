import 'package:amazone_app1/comman/widgets/loader_indicator.dart';
import 'package:amazone_app1/features/acccount/widgets/single_product.dart';
import 'package:amazone_app1/features/admin/screens/add_product_screen.dart';
import 'package:amazone_app1/features/admin/service/admin_service.dart';
import 'package:amazone_app1/models/product.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Product>? products;
  final AdminService adminServices = AdminService();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(
                          image: productData.images[0],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                deleteProduct(productData, index);
                              },
                              icon: const Icon(Icons.delete_outlined)),
                        ],
                      )
                    ],
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
