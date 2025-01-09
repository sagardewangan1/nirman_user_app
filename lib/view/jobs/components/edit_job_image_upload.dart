import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/jobs_service/edit_job_service.dart';
import 'package:qixer/view/utils/common_helper.dart';

class EditJobUploadImage extends StatelessWidget {
  const EditJobUploadImage({super.key, required this.prevImageLink});

  final prevImageLink;

  @override
  Widget build(BuildContext context) {
    return Consumer<EditJobService>(
      builder: (context, provider, child) => Consumer<AppStringService>(
        builder: (context, ln, child) => Column(
          children: [
            provider.pickedImage == null
                ? prevImageLink != null
                    ? CommonHelper().profileImage(prevImageLink, 85, 85)
                    : Image.asset(
                        'assets/images/avatar.png',
                        height: 85,
                        width: 85,
                        fit: BoxFit.cover,
                      )
                : Image.file(
                    File(provider.pickedImage!.path),
                    height: 85,
                    width: 85,
                    fit: BoxFit.cover,
                  ),

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
