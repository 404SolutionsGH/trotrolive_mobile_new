import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trotrolive_mobile_new/utils/constants/color%20constants/colors.dart';

class StationShimmerTile extends StatelessWidget {
  const StationShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBg,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (_, __) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
