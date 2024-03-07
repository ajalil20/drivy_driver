import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../../base_view.dart';

class Rules extends StatelessWidget {
  Rules({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Rules",
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                pointText(p: '1.', t: 'Lorem ipsum dolor sit amet consectetur. Nulla potenti montes vitae ac ornare. Pulvinar urna elementum sed consectetur dictumst et. Pretium sapien mauris amet pharetra a pharetra. Dolor tellus sed quam dui. Ante vulputate semper sit velit ac auctor. Morbi orci tempor viverra pulvinar.'),
                SizedBox(height: 2.h,),
                pointText(p: '2.', t: 'In sit sed lobortis ullamcorper mi vitae. Pellentesque vestibulum at massa posuere mollis. Nunc sapien senectus quis sed eget vel quis curabitur. Nulla volutpat mollis in ut sed. Gravida nec mattis fames id ultrices elementum pharetra montes. Nulla sed vulputate amet tempor gravida cursus. Ultrices quis ornare orci adipiscing. Quam egestas enim sem sed sed proin bibendum. Lectus elit et pellentesque ut. Elit id mattis id vel neque arcu massa et amet. Dolor ut integer nisl sagittis placerat turpis commodo id sagittis. In quisque tincidunt id vulputate at orci. Aliquam bibendum lectus amet volutpat. Lacus aliquet eu hendrerit eget.'),
                SizedBox(height: 2.h,),
                pointText(p: '3.', t: 'Egestas nisi rutrum interdum pretium integer amet integer. Sollicitudin molestie mattis dui pharetra sed sed rhoncus dui tempor. Ullamcorper bibendum blandit tempor porttitor lorem lectus sit at egestas. Commodo justo dolor aenean ut libero nisi vitae quis. At dui non et ipsum. Nisl nibh congue massa euismod nunc lectus aliquam ut vitae. Dictumst quisque diam ac sapien lorem sem bibendum consectetur. Interdum dui habitant morbi et cum. Praesent amet sed mauris turpis faucibus posuere in. In semper enim sit quisque sit amet. Eget enim dui est mi cum tellus. Tristique maecenas feugiat.'),

              ],),
          ),
        )
    );
  }
  pointText({p ,t}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(title: '$p   ',fontWeight: FontWeight.w600 ,clr: MyColors().greyColor ,size: 12,),
        Expanded(child: MyText(title: t,size: 12 ,)),
      ],
    );
  }

}
