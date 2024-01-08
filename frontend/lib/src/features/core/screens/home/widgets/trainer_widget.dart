import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/utils/assets.dart';

class TrainerWidgets extends StatelessWidget {
  const TrainerWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Row(
          children: [
            Container(
              height: 200.h,
              width: 150.w,
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
                  width: 170.w,
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
                  width: 170.w,
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
      ),
    );
  }
}
