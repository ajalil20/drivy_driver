// import 'package:flutter/material.dart';
//
// import '../../../../Utils/my_colors.dart';
// import '../../../../Utils/responsive.dart';
// import '../../../Component/custom_text.dart';
// import 'package:sizer/sizer.dart';
//
// import 'base_view.dart';
//
// class PrivacyPolicy extends StatelessWidget {
//   Responsive responsive = Responsive();
//   MyColors colors = MyColors();
//
//   PrivacyPolicy({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     //   statusBarColor: Theme.of(context).primaryColorDark.withOpacity(1),
//     //   statusBarBrightness: Brightness.dark,
//     // ));
//     responsive.setContext(context);
//     return BaseView(
//       screenTitle: "PRIVACY POLICY",
//       showAppBar: true,
//       showBackButton: true,
//       resizeBottomInset: false,
//
//       screenTitleColor: Theme
//           .of(context)
//           .primaryColor,
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.w),
//             child: const Divider(),
//           ),
//           SizedBox(height: responsive.setHeight(2)),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(8)),
//               child: const SingleChildScrollView(
//                 physics: BouncingScrollPhysics(),
//                 child: MyText(
//                   title: "Lorem ipsum dolor sit amet. Ut explicabo pariatur vel magnam temporibus eos voluptatem asperiores ut quod asperiores non dolores enim et voluptatem autem non nihil eaque. Rem fugit repudiandae est placeat provident aut necessitatibus tempora. Non voluptatem dolorem aut nostrum dolorum et asperiores culpa sed voluptatibus officia est dolor assumenda aut omnis natus.\n\nEt asperiores similique sit animi repellendus aut iusto nostrum eos velit exercitationem. Et galisum provident sed quia maiores quo aliquam laboriosam ut tempora galisum rem nisi iusto hic iure quam sed assumenda tenetur. A voluptatem ducimus ut atque pariatur id nihil expedita. Quo placeat soluta ut minima impedit rem corporis sequi a voluptate velit eum rerum odit.\n\nAd earum distinctio vel reiciendis aspernatur sed minus aliquid et perspiciatis sequi ea laboriosam voluptatem cum esse eligendi. Id maxime commodi ut eaque quis et laborum quia id quia alias aut sapiente Quis eum nostrum neque! Et quod nemo sit beatae accusamus aut quia necessitatibus At voluptatem corrupti. Et asperiores similique sit animi repellendus aut iusto nostrum eos velit exercitationem. Et galisum provident sed quia maiores quo aliquam laboriosam ut tempora galisum rem nisi iusto hic iure quam sed assumenda tenetur. A voluptatem ducimus ut atque pariatur id nihil expedita. Quo placeat soluta ut minima impedit rem corporis sequi a voluptate velit eum rerum odit. Et asperiores similique sit animi repellendus aut iusto nostrum eos velit exercitationem. Et galisum provident sed quia maiores quo aliquam laboriosam ut tempora galisum rem nisi iusto hic iure quam sed assumenda tenetur. A voluptatem ducimus ut atque pariatur id nihil expedita. Quo placeat soluta ut minima impedit rem corporis sequi a voluptate velit eum rerum odit.",
//                   clr: Colors.grey,
//                   weight: "Semi Bold",
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: responsive.setHeight(3)),
//
//         ],
//       ),
//     );
//   }
// }
