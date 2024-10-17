
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/module/clubCommittee/data/club_committee_data_fetch.dart';
import 'package:nubcc/module/clubCommittee/widget/club_committee_card.dart';

import '../../../const/font_constant.dart';

class ClubCommitteeView extends StatefulWidget {
  const ClubCommitteeView({super.key});

  @override
  State<ClubCommitteeView> createState() => _ClubCommitteeViewState();
}

class _ClubCommitteeViewState extends State<ClubCommitteeView> {

  final ScrollController scrollController = ScrollController();

  bool isLoading = true;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    fetchStudentData();
    scrollController.addListener(() async {
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        fetchStudentData();
        setState(() {});
      }
    },);
  }

  void fetchStudentData() async {
    hasMoreData = await ClubCommitteeDataFetch.initAndFetchData();
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Club Committee",
            style: TextStyle(
                letterSpacing: 5,
                fontSize: TextSize.font24(context),
                fontWeight: FontWeight.w700,
                color: AppColor.baseColor
            ),
          ),
          centerTitle: true,
          foregroundColor: AppColor.baseColor,
          shadowColor: AppColor.baseColorShade500,
          surfaceTintColor: Colors.blueAccent,
        ),
        body: isLoading
            ? Center(
              heightFactor: 10,
              child: LoadingAnimationWidget.hexagonDots(
                  color: AppColor.baseColor,
                  size: Get.height/10
              ),
            ) // Show loading spinner while data is being fetched
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
             // child: Center(child: Text(ClubCommitteeDataFetch.clubCommitteeList.length.toString())),
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: ClubCommitteeDataFetch.clubCommitteeList.length + 1,
                  itemBuilder: (context, index) {
                    if(index < ClubCommitteeDataFetch.clubCommitteeList.length){
                      final clubCommittee = ClubCommitteeDataFetch.clubCommitteeList[index];
                      return ClubCommitteeCard(clubCommittee: clubCommittee);
                    }
                    else{
                      if(hasMoreData == false){
                        return Center(
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: AppColor.baseColorShade500,
                                    shape: BoxShape.circle
                                ),
                                child: Text(ClubCommitteeDataFetch.clubCommitteeList.length.toString())
                            )
                        );
                      }
                      else{
                        if(ClubCommitteeDataFetch.clubCommitteeList.length < 10){
                          return const SizedBox();
                        }
                        else{
                          return Center(
                            heightFactor: 10,
                            child: LoadingAnimationWidget.hexagonDots(
                                color: AppColor.baseColor,
                                size:  Get.height / 15
                            ),
                          );
                        }
                      }
                    }
                  }
              ),
            )
    );
  }
}


