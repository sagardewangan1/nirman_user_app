import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/orders_service.dart';
import 'package:qixer/view/booking/components/textarea_field.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

class DeclineOrderPage extends StatefulWidget {
  const DeclineOrderPage({
    super.key,
    required this.orderId,
    required this.sellerId,
  });

  final orderId;
  final sellerId;

  @override
  State<DeclineOrderPage> createState() => _DeclineOrderPageState();
}

class _DeclineOrderPageState extends State<DeclineOrderPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('Decline', context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Consumer<OrdersService>(
          builder: (context, oProvider, child) => Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              sizedBoxCustom(20),
              Text(
                lnProvider
                    .getString('Describe why you want to decline the request'),
                style: TextStyle(
                    color: cc.greyFour,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              sizedBoxCustom(20),
              TextareaField(
                notesController: controller,
                hintText: lnProvider.getString('Decline reason'),
              ),
              sizedBoxCustom(30),
              CommonHelper().buttonOrange('Decline', () {
                if (oProvider.markLoading) return;

                if (controller.text.trim().isEmpty) {
                  OthersHelper()
                      .showToast('You must enter decline reason', Colors.black);
                  return;
                }

                FocusManager.instance.primaryFocus?.unfocus();

                oProvider.declineOrder(context,
                    orderId: widget.orderId,
                    sellerId: widget.sellerId,
                    declineReason: controller.text);
              }, bgColor: Colors.red, isloading: oProvider.markLoading),
            ]),
          ),
        ),
      ),
    );
  }
}
