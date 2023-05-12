import 'dart:io';
import 'package:amazone_app1/constant/error_handling.dart';
import 'package:amazone_app1/constant/global_variable.dart';
import 'package:amazone_app1/constant/utils.dart';
import 'package:amazone_app1/models/product.dart';
import 'package:amazone_app1/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("dksbzsnmw", "me6b1rkp");
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-products/'),
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'x-auth-token': userProvider.user.token
        },
        body: product.toJson(),
      );
      // ignore: use_build_context_synchronously
      httpErorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully!');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
