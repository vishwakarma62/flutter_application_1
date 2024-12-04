// import 'package:postervibe/presentation/widget/app_button.dart';
// import 'package:postervibe/routes/app_routes.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:postervibe/core/app_export.dart';
// import 'package:postervibe/presentation/auth/intro/intro_controller.dart';

// class IntroScreen extends StatefulWidget {
// const  IntroScreen({super.key});

//   @override
//   State<IntroScreen> createState() => _IntroScreenState();
// }

// class _IntroScreenState extends State<IntroScreen> {
//   final IntroController _controller = Get.put(IntroController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//           body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {
//                     Get.toNamed(AppRoute.login);
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "skip".tr,
//                         style: TextStyle(
//                           color: Get.isDarkMode
//                               ? Colors.white.withOpacity(.6)
//                               : Colors.black.withOpacity(.6),
//                           fontSize: 13,
//                         ),
//                       ),
//                       Icon(
//                         Icons.chevron_right_rounded,
//                         size: 18,
//                         color: Get.isDarkMode
//                             ? Colors.white.withOpacity(.6)
//                             : Colors.black.withOpacity(.6),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             CarouselSlider(
//               carouselController: _controller.carouselController,
//               options: CarouselOptions(
//                   enableInfiniteScroll: false,
//                   autoPlay: false,
//                   viewportFraction: 1,
//                   aspectRatio: 3 / 2,
//                   onPageChanged: (i, reason) {
//                     _controller.selectedIndex.value = i;
//                   }),
//               items: _controller.list.map((item) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                         item['image'],
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             Obx(
//               () => Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: _controller.list
//                     .asMap()
//                     .map((i, item) => MapEntry(
//                           i,
//                           Container(
//                             height: 10,
//                             width:
//                                 _controller.selectedIndex.value == i ? 20 : 10,
//                             margin: const EdgeInsets.only(right: 5),
//                             decoration: BoxDecoration(
//                               border: _controller.selectedIndex.value == i
//                                   ? null
//                                   : Border.all(color: const Color(0xffB8BABF)),
//                               borderRadius: BorderRadius.circular(20),
//                               color: _controller.selectedIndex.value == i
//                                   ? const Color(0xffFC8B5F)
//                                   : Colors.transparent,
//                             ),
//                           ),
//                         ))
//                     .values
//                     .toList(),
//               ),
//             ),
//             SizedBox(
//               height: Get.height < 600 ? Get.height * .3 : Get.height * .2,
//               // color: Colors.amberAccent,
//               child: Column(
//                 children: [
//                   Obx(
//                     () => Text(
//                       _controller.list[_controller.selectedIndex.value]
//                           ['title'],
//                       maxLines: 2,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   hSizedBox20,
//                   Obx(
//                     () => Text(
//                       _controller.list[_controller.selectedIndex.value]
//                           ['discription'],
//                       textAlign: TextAlign.center,
//                       maxLines: 4,
//                       style: TextStyle(
//                         color: Get.isDarkMode
//                             ? Colors.white.withOpacity(.8)
//                             : Colors.black.withOpacity(.6),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: AppButton(
//                 text: _controller.selectedIndex.value == 3
//                     ? "start".tr
//                     : "next".tr,
//                 onPressed: () {
//                   if (_controller.selectedIndex.value == 3) {
//                     Get.toNamed(AppRoute.login);
//                   } else {
//                     _controller.carouselController.nextPage();
//                   }
//                 },
//               ),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }
