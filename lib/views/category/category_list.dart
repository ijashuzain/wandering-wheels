import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/views/category/category_create.dart';
import 'package:wandering_wheels/views/home/widgets/category_card.dart';

class CategoryList extends StatefulWidget {
  final bool isManage;

  static String routeName = "/category_list";
  CategoryList({Key? key, this.isManage = false}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  void fetchCategories(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read<CategoryProvider>().fetchCategories();
    });
  }

  @override
  void initState() {
    fetchCategories(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: const Text(
          "Categories",
          style: TextStyle(color: kPrimaryColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              fetchCategories(context);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryCreate(
                        isUpdate: false,
                      )));
        },
        child: const Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (provider.categories.isEmpty) {
            return const Center(
              child: Text("No categories found"),
            );
          }
          return SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.categories.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        categoryName: provider.categories[index].name,
                        categoryImage: provider.categories[index].image,
                        avilableCars: "1",
                        onTap: () {
                          if (widget.isManage) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryCreate(
                                  isUpdate: true,
                                  category: provider.categories[index],
                                ),
                              ),
                            );
                          } else {
                            //
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
