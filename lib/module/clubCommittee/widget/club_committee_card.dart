import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nubcc/global/widget/link_button_card.dart';
import 'package:nubcc/module/clubCommittee/model/club_committee_model.dart';
import 'package:nubcc/config/responsive_scale.dart';
import 'package:nubcc/const/app_colors.dart';
import 'package:nubcc/const/font_constant.dart';

class ClubCommitteeCard extends StatefulWidget {
  const ClubCommitteeCard({
    super.key,
    required this.clubCommittee,
  });

  final ClubCommitteeModel clubCommittee;

  @override
  State<ClubCommitteeCard> createState() => _ClubCommitteeCardState();
}

class _ClubCommitteeCardState extends State<ClubCommitteeCard> {

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: AppColor.baseColor.withOpacity(.2)),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, spreadRadius: 1)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
                ),
                child: Text(
                  widget.clubCommittee.name != null && widget.clubCommittee.name!.isNotEmpty
                      ? widget.clubCommittee.name![0].toUpperCase()
                      : '',
                  style: TextStyle(fontSize: TextSize.font36(context)),
                ),
              ),
              SizedBox(width: ResponsiveScale.of(context).wp(2)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.clubCommittee.role ?? "unknown",
                      style:  TextStyle(fontWeight: FontWeight.bold,fontSize: TextSize.font18(context),color: AppColor.baseColor),
                    ),
                    Text(widget.clubCommittee.name ?? " --- ",
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: TextSize.font18(context)))
                  ],
                ),
              ),
            ],
          ),
          !_isExpanded ?
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded; // Toggle the expanded state
              });
            },
            child:Text("Details", style: TextStyle(color: AppColor.baseColor)),
          )
          : Container(
            height: 1,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(top: 10),
            decoration:BoxDecoration(
              color: AppColor.baseColorShade300
            ) ,
          ),
          if (_isExpanded) // Conditionally show additional content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.clubCommittee.semester ?? " --- "),
                              Text(widget.clubCommittee.section ?? " --- "),
                              Text(widget.clubCommittee.id ?? " --- "),
                              Text(widget.clubCommittee.contact ?? " --- "),
                              Text(widget.clubCommittee.email ?? " --- "),
                              Text(widget.clubCommittee.hometown ?? " --- "),
                              Text(widget.clubCommittee.bloodGroup ?? " --- "),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LinkButtonCard( icon: Icons.call, title: 'Call', onTap: () {  },),
                              LinkButtonCard( icon: Icons.call, title: 'Call', onTap: () {  },),
                              LinkButtonCard( icon: Icons.call, title: 'Call', onTap: () {  },),
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                  _isExpanded ?
                     InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded; // Toggle the expanded state
                      });
                    },
                    child:Text("Minimize", style: TextStyle(color: AppColor.baseColor)),
                  ) : const SizedBox()
                ],
              ) // Replace this with actual details content
            ),
        ],
      ),
    );
  }
}