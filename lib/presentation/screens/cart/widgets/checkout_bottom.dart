import 'package:e_commerce_app/business_logic/common_blocs/cart/bloc.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/dialog.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';
import 'package:e_commerce_app/presentation/widgets/buttons/default_button.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CheckoutBottom extends StatelessWidget {
  const CheckoutBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -0.5),
              color: Colors.black12,
              blurRadius: 5,
            )
          ],
        ),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Total price
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: SizeConfig.defaultSize * 4,
                      width: SizeConfig.defaultSize * 4,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset("assets/icons/receipt.svg"),
                    ),
                    SizedBox(width: SizeConfig.defaultSize * 1.5),
                    _buildTotalPrice(context, state),
                  ],
                ),
                SizedBox(height: SizeConfig.defaultSize * 2),
                _buildCheckoutButton(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildCheckoutButton(BuildContext context, CartState state) {
    return DefaultButton(
      child: Text(
        Translate.of(context).translate("check_out"),
        style: FONT_CONST.BOLD_WHITE_18,
      ),
      onPressed: () {
        if (state is CartLoaded && state.cart.length > 0) {
          Navigator.pushNamed(context, AppRouter.PAYMENT);
        } else {
          UtilDialog.showInformation(
            context,
            content: Translate.of(context).translate("your_cart_is_empty"),
          );
        }
      },
    );
  }

  _buildTotalPrice(BuildContext context, CartState state) {
    String totalPrice =
        state is CartLoaded ? formatNumber(state.totalCartPrice) : "0";
    return Text.rich(
      TextSpan(
        style: FONT_CONST.REGULAR_DEFAULT_16,
        children: [
          TextSpan(text: Translate.of(context).translate("total") + "\n"),
          TextSpan(
            text: "$totalPrice₫",
            style: FONT_CONST.BOLD_PRIMARY_18,
          ),
        ],
      ),
    );
  }
}
