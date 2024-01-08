import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/utils/assets.dart';
import 'package:get/get.dart';

class GymDetalScreen extends StatefulWidget {
  const GymDetalScreen({super.key});

  @override
  State<GymDetalScreen> createState() => _GymDetalScreenState();
}

class _GymDetalScreenState extends State<GymDetalScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 70,
                bottom: 20,
                right: 20,
                left: 20,
              ),
              height: height / 3,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AssetsImages.userJpg),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AssetsImages.userJpg),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Gym Name",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.cOrange),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    "Gym Name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.cOrange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Join",
                            style: TextStyle(color: AppColors.cWhiteClr),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            const CategoryTitle(title: "forYou"),
            TrainerWidgets(),
          ],
        ),
      ),
    );
  }
}

class TrainerWidgets extends StatelessWidget {
  const TrainerWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Row(
        children: [
          Container(
            height: 200.h,
            width: 160.w,
            decoration: BoxDecoration(
              color: AppColors.cOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Tewodros GymBet",
                      style: TextStyle(
                        color: AppColors.cWhiteClr,
                        fontSize: 16.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    child: Image.asset(
                      AssetsImages.userJpg,
                      height: 140.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Column(
            children: [
              Container(
                height: 100.h,
                width: 180.w,
                decoration: BoxDecoration(
                  color: AppColors.cOrange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Total User",
                          style: TextStyle(
                            color: AppColors.cWhiteClr,
                            fontSize: 16.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 100.h,
                width: 180.w,
                decoration: BoxDecoration(
                  color: AppColors.cOrange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Total User",
                          style: TextStyle(
                            color: AppColors.cWhiteClr,
                            fontSize: 16.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
