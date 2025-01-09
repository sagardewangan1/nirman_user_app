// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/service/booking_services/personalization_service.dart';
import 'package:qixer/service/jobs_service/job_request_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class TotalPayable extends StatelessWidget {
  const TotalPayable(
      {super.key,
      required this.isFromOrderExtraAccept,
      required this.isFromJobHire});

  final isFromOrderExtraAccept;
  final isFromJobHire;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<AppStringService>(
          builder: (context, ln, child) => Consumer<BookConfirmationService>(
              builder: (context, bcProvider, child) =>
                  Consumer<PersonalizationService>(
                    builder: (context, pProvider, child) {
                      var price;
                      if (isFromOrderExtraAccept == true) {
                        price = Provider.of<OrderDetailsService>(context,
                                listen: false)
                            .selectedExtraPrice;
                      } else if (isFromJobHire) {
                        price = Provider.of<JobRequestService>(context,
                                listen: false)
                            .selectedJobPrice;
                      } else {
                        if (pProvider.isOnline == 0) {
                          price = bcProvider.totalPriceAfterAllcalculation
                              .toStringAsFixed(2);
                        } else {
                          price = bcProvider
                              .totalPriceOnlineServiceAfterAllCalculation
                              .toStringAsFixed(2);
                        }
                      }

                      return BookingHelper().detailsPanelRow(
                          ln.getString('Total Payable'), 0, price);
                    },
                  )),
        ),
        sizedBoxCustom(10)
      ],
    );
  }
}
