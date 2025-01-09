import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/jobs_service/create_job_service.dart';
import 'package:qixer/view/utils/common_helper.dart';

class CreateJobUploadImage extends StatelessWidget {
  const CreateJobUploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateJobService>(
      builder: (context, provider, child) => Consumer<AppStringService>(
        builder: (context, ln, child) => Column(
          children: [
            provider.pickedImage != null
                ? Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 80,
                        child: ListView(
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            // for (int i = 0;
                            //     i <
                            //         provider
                            //             .images!.length;
                            //     i++)
                            InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Image.file(
                                      // File(provider.images[i].path),
                                      File(provider.pickedImage.path),
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),

            //pick image button =====>
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CommonHelper().buttonOrange(ln.getString('Choose images'), () {
                  provider.pickAddressImage(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
