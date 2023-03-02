import 'package:flutter/material.dart';
import '../../data/models/product/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:400,
        width:220,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation:2,
          // shadowColor: Theme.of(context).colorScheme.surfaceVariant,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              SizedBox(
                height:140,
                width:180,
                child: Image.network(product.productPicture,
                // height:145,
                // width:220,
                      fit: BoxFit.cover,
                ),
              ),
              TextButton(
                child: Text(
                  '${product.productAuthor}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1, fontSize: 17),
                  textAlign: TextAlign.center,
                  ),
                onPressed: () {/* ... */},
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  product.productName,
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                   style: const TextStyle(fontSize: 16.0, height: 1),
                   textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '${product.productPrice}',
                   overflow: TextOverflow.ellipsis,
                   textAlign: TextAlign.center,
                   style: const TextStyle(fontWeight: FontWeight.bold, height:1.5, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  product.productCondition,
                   overflow: TextOverflow.ellipsis,
                   textAlign: TextAlign.center,
                   style: const TextStyle( height:1.5, fontSize: 16),
                ),
              ),
                ],
          ),
        ),
    );
  }
}

