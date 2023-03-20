import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goodtech/states/authen.dart';
import 'package:goodtech/states/display_category_technic.dart';
import 'package:goodtech/utility/app_controller.dart';
import 'package:goodtech/utility/app_dialog.dart';
import 'package:goodtech/widgets/widget_image.dart';
import 'package:goodtech/widgets/widget_text.dart';
import 'package:goodtech/widgets/widget_text_button.dart';

class CategoryTechnic extends StatelessWidget {
  const CategoryTechnic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('typeuser ---> ${appController.typeUsers.length}');
          return appController.typeUsers.isEmpty
              ? const SizedBox()
              : GridView.builder(
                  itemCount: appController.typeUsers.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      crossAxisCount: 4),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (appController.userModelLogins.isEmpty) {
                        AppDialog(context: context).normalDialog(
                            title: 'ยังไม่ได้ลงชื่อเข้าใช้งาน',
                            detail: 'กรุณา ลงชื่อเข้าใช้งาน',
                            firstBotton: WidgetTextButton(
                              label: 'ลงชื่อเข้าใช้งาน',
                              pressFunc: () {
                                Get.back();
                                Get.to(const Authen());
                              },
                            ));
                      } else {
                        Get.to(DisplayCategoryTechnic(
                          category: appController.typeUsers[index],
                          pathImage: 'images/category$index.png',
                        ));
                      }
                    },
                    child: Card(
                      color: Colors.green.shade100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetImage(
                            size: 48,
                            path: 'images/category$index.png',
                          ),
                          WidgetText(text: appController.typeUsers[index]),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}