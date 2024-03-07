import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Component/custom_text.dart';
import '../../Utils/responsive.dart';

class MessageDisclosureAlert extends StatelessWidget {
  Responsive responsive = Responsive();
  Rx<TextEditingController> timeline = TextEditingController().obs;

  MessageDisclosureAlert({super.key});

  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      // height: responsive.setHeight(75),
      width: responsive.setWidth(100),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: const BoxDecoration(
                  // color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20)
                    )),

                child: ListTile(
                    title: Center(child: Align(
                      alignment: const Alignment(.2, 0),
                      child: MyText(title: "Disclosure".toUpperCase(),clr:Theme.of(context).primaryColor,center: true,weight: "Semi Bold",),)),
                    trailing:GestureDetector(
                        onTap: (){Get.back();},
                        child: Icon(Icons.cancel,color:Theme.of(context).primaryColorDark,))
                )
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.setWidth(8)),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // SizedBox(height: 2.h,),
                  const MyText(
                    title: 'Thank you for utilizing our Raive! Chat feature. Please note that in using the service it is understood that this service is not intended to provide nor replace any clinical diagnosis, unless otherwise stated during the tele-med consultation. Information exchanged is for peer to peer educational purposes only. All clinical final diagnosis, treatment planning, and treatment are the responsibility of the primary care physician. To abide by HIPPA and Omnibus Rule. Protect your patients privacy and identity. do not upload or send PPI. Non-identifiable photos, X-rays, etc are allowed for better understanding of the case. Any evident PPI violation will be deleted immediately.',
                    // weight: "Semi Bold",
                    clr: Color(0xff858585),
                    size: 14,
                    center: true,
                    toverflow: TextOverflow.ellipsis,
                    line: 30,
                    // size: 18,
                  ),
                  SizedBox(height: 2.h,),

                  SizedBox(height: 2.h,),


                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
