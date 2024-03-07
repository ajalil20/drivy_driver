import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_icon_container.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/stream_model.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Widget/search_tile.dart';
import 'package:drivy_driver/View/Widget/streaming_card.dart';

import 'package:drivy_driver/View/Widget/view_all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drivy_driver/View/base_view.dart';
import '../../../Utils/image_path.dart';
import '../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InfluencerHome extends StatefulWidget {
  const InfluencerHome({super.key});

  @override
  State<InfluencerHome> createState() => _InfluencerHomeState();
}

class _InfluencerHomeState extends State<InfluencerHome> {
  TextEditingController s = TextEditingController();
  RxBool searchOn = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => true);
        // return Utils().onWillPop(context, currentBackPressTime: currentBackPressTime);
      },
      child: BaseView(
        showAppBar: false,
        showBottomBar: true,
        resizeBottomInset: false,
        showDrawer: false,
        showBackButton: false,
        screenTitle: "Home",
        leadingAppBar: MenuIcon(),
        trailingAppBar: NotificationIcon(),
        child: GetBuilder<HomeController>(
            builder: (d) {
            return CustomRefresh(
              onRefresh: () async {
                await fetchData(loading: false);
              },
              child: CustomPadding(
                topPadding: 2.h,
                horizontalPadding: 4.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(screenTitle: "Home",leading: MenuIcon(),trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ChatIcon(),
                        SizedBox(width: 2.w,),
                        NotificationIcon(),
                      ],
                    ),bottom: 2.h,),
                    SearchTile(
                      onChange: (val) {
                        if (val.isNotEmpty) {
                          searchOn.value = true;
                          d.getSearchStream(s: val);
                        }
                        else {
                          searchOn.value = false;
                          d.update();
                        }
                      },
                      search:s,
                      showFilter: false,
                    ),
                    SizedBox(height: 1.5.h),
                    MyText(title:"Invites",size: 17,clr: MyColors().blueColor,fontWeight: FontWeight.w700,),
                    SizedBox(height: 1.5.h),
                    streamsList(s:searchOn.isTrue?d.searchStreams:d.streams),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  getData(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      fetchData(loading: true);
    });
  }
  Widget streamsList({required RxList<StreamModel> s}){
    return Expanded(
      child: s.isEmpty?CustomEmptyData(title: 'No Invites',):
      ListView.builder(
          physics: AlwaysScrollableScrollPhysics(parent: const ClampingScrollPhysics()),
          shrinkWrap: true,
          itemCount: s.length,
          itemBuilder: (context,index){
            return StreamCard(height: 21.h,bottomPadding: 1.5.h,isInvitation: true,s: s[index]);
          }),
    );
  }
  Future<void> fetchData({loading}) async{
    await HomeController.i.getStreaming(loading:loading??true,context: context);
  }
}
