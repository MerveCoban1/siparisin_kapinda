import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/service/firestore_service.dart';
import 'package:siparisin_kapinda/widgets/product_card_widget.dart';
import 'package:siparisin_kapinda/widgets/search/search_product_card_widget.dart';

class SearchItems extends StatefulWidget {
  late String text;
  SearchItems(this.text);

  @override
  _SearchItemsState createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  FirestoreService service = FirestoreService();
  var productList = [];

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      width: (MediaQuery.of(context).size.height),
      height: (MediaQuery.of(context).size.height) * 0.80,
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          return SearchProductCardWidget(productList[index], widget.text);
        },
      ),
    );
  }

  void fetchProducts() async {
    //product doldurulacak firebase ile
    var incomingProductList = await service.getAllProducts();
    if (incomingProductList.isEmpty) {
      print("Veri yok");
    } else {
      setState(() {
        productList = incomingProductList;
      });
    }
  }
}
