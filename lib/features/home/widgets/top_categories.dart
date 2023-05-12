import 'package:amazone_app1/constant/global_variable.dart';

import 'package:flutter/widgets.dart';

class TopCategory extends StatefulWidget {
  const TopCategory({super.key});

  @override
  State<TopCategory> createState() => _TopCategoryState();
}

class _TopCategoryState extends State<TopCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemExtent: 75,
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    GlobalVariables.categoryImages[index]['image']!,
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              Text(
                GlobalVariables.categoryImages[index]['title']!,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
              ),
            ],
          );
        },
      ),
    );
  }
}
