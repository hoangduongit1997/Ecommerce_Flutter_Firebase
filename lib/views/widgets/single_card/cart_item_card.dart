import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/business_logic/repository/product_repository/firebase_product_repo.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';

import 'package:e_commerce_app/views/widgets/buttons/circle_icon_button.dart';
import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key key,
    this.cartItem,
    this.allowChangeQuantity = true,
  }) : super(key: key);

  final CartItem cartItem;
  final bool allowChangeQuantity;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseProductRepository().getProductById(cartItem.pid),
      builder: (context, snapshot) {
        Product product = snapshot.data;
        return snapshot.hasData
            ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.DETAIL_PRODUCT,
                    arguments: product,
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 5,
                        color: mPrimaryColor.withOpacity(0.2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _buildCartItemImage(product),
                      SizedBox(width: 10),
                      Expanded(child: _buildCartItemInfo(product, context)),
                    ],
                  ),
                ),
              )
            // Loading
            : Container();
      },
    );
  }

  // CartItem image
  _buildCartItemImage(Product product) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Image.network(product.images[0])),
    );
  }

  // CartItem Info
  _buildCartItemInfo(Product product, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text(
          "${product.name}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
        SizedBox(height: 5),
        // Cart item price
        Text(
          "${formatNumber(product.originalPrice)} ₫",
          style: TextStyle(color: mPrimaryColor, fontSize: 17),
        ),
        SizedBox(height: 5),

        allowChangeQuantity
            ? _buildCartItemQuantity(product, context)
            : Text("x ${cartItem.quantity}")
      ],
    );
  }

  // Cart item quantity
  _buildCartItemQuantity(Product product, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // decrease button
        CircleIconButton(
          svgIcon: "assets/icons/subtract.svg",
          color: Color(0xFFF5F6F9),
          size: 14,
          onPressed: cartItem.quantity > 1
              ? () => _changeQuantity(context, product, cartItem.quantity - 1)
              : () {},
        ),

        // quantity
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "${cartItem.quantity}",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // // increase button
        CircleIconButton(
          svgIcon: "assets/icons/add.svg",
          color: Color(0xFFF5F6F9),
          size: 14,
          onPressed: cartItem.quantity < product.quantity
              ? () => _changeQuantity(context, product, cartItem.quantity + 1)
              : () {},
        )
      ],
    );
  }

  _changeQuantity(BuildContext context, Product product, int newQuantity) {
    var newPrice = newQuantity * product.originalPrice;

    // update cart item
    BlocProvider.of<CartBloc>(context).add(UpdateCartItem(
      cartItem.cloneWith(
        quantity: newQuantity,
        price: newPrice,
      ),
    ));
  }
}
