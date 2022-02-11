import 'package:flutter/material.dart';

class ProductsWithCart extends StatefulWidget {
  const ProductsWithCart({Key? key}) : super(key: key);

  @override
  _ProductsWithCartState createState() => _ProductsWithCartState();
}

class _ProductsWithCartState extends State<ProductsWithCart> {
  
  var allProducts = [
    {
      "id": 1,
      "name": "Fish",
      "description": "full",
      "quantity": 10,
      "price": 200,
    },
    {
      "id": 1,
      "name": "Fish",
      "description": "half",
      "quantity": 10,
      "price": 100
    },
    {
      "id": 2,
      "name": "Pizza",
      "description": "half",
      "quantity": 10,
      "price": 100
    },
    {
      "id": 2,
      "name": "Pizza",
      "description": "full",
      "quantity": 10,
      "price": 200
    },
  ];

  var cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products with Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ProductsWithCart()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("All Products", style: TextStyle(fontSize: 30)),
                Icon(Icons.inventory_2, size: 30),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: allProducts.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  const Text("ID",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(allProducts[index]["id"].toString()),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Name: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(allProducts[index]['name'].toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Desc: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(allProducts[index]['description']
                                        .toString()),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text("Stock: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(allProducts[index]['quantity']
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Price: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        allProducts[index]['price'].toString()),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    var q = allProducts[index]['quantity']
                                        .toString();

                                    if (q == "0") {
                                      return;
                                    }

                                    allProducts[index]['quantity'] =
                                        int.parse(q) - 1;

                                    var i = cartItems.indexWhere((element) =>
                                        element["id"] ==
                                            allProducts[index]['id'] &&
                                        element["description"] ==
                                            allProducts[index]['description']);
                                    if (i >= 0) {
                                      var qty =
                                          cartItems[i]['quantity'].toString();

                                      cartItems[i]['quantity'] =
                                          int.parse(qty) + 1;
                                    } else {
                                      cartItems.add({
                                        "id": allProducts[index]["id"],
                                        "name": allProducts[index]["name"],
                                        "description": allProducts[index]
                                            ["description"],
                                        "quantity": 1,
                                        "price": allProducts[index]["price"],
                                      });
                                    }
                                    setState(() {});
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(
                                      () {
                                        var qty = allProducts[index]['quantity']
                                            .toString();

                                        if (qty == "10") {
                                          return;
                                        }

                                        allProducts[index]['quantity'] =
                                            int.parse(qty) + 1;

                                        var i = cartItems.indexWhere(
                                            (element) =>
                                                element["id"] ==
                                                    allProducts[index]['id'] &&
                                                element["description"] ==
                                                    allProducts[index]
                                                        ['description']);
                                        if (i >= 0) {
                                          var qty = cartItems[i]['quantity']
                                              .toString();
                                          if (qty == "1") {
                                            cartItems.removeAt(i);
                                          } else {
                                            cartItems[i]['quantity'] =
                                                int.parse(qty) - 1;
                                          }
                                        }
                                        ;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Carted Products", style: TextStyle(fontSize: 30)),
                Icon(Icons.shopping_cart, size: 30),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            cartItems.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Card(
                            elevation: 5,
                            color: Colors.blue.shade50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text("ID",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(cartItems[index]["id"].toString()),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Name: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(cartItems[index]['name']
                                              .toString()),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Desc: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(cartItems[index]['description']
                                              .toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("QTY: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(cartItems[index]['quantity']
                                              .toString()),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Price: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(cartItems[index]['price']
                                              .toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          var q = cartItems[index]['quantity']
                                              .toString();

                                          if (q == "10") {
                                            return;
                                          }

                                          cartItems[index]['quantity'] =
                                              int.parse(q) + 1;

                                          var i = allProducts.indexWhere(
                                              (element) =>
                                                  element["id"] ==
                                                      cartItems[index]['id'] &&
                                                  element["description"] ==
                                                      cartItems[index]
                                                          ['description']);
                                          var qty = allProducts[i]['quantity']
                                              .toString();

                                          allProducts[i]['quantity'] =
                                              int.parse(qty) - 1;

                                          setState(() {});
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          setState(
                                            () {
                                              var qty = cartItems[index]
                                                      ['quantity']
                                                  .toString();

                                              var i = allProducts.indexWhere(
                                                  (element) =>
                                                      element["id"] ==
                                                          cartItems[index]
                                                              ['id'] &&
                                                      element["description"] ==
                                                          cartItems[index]
                                                              ['description']);
                                              var q = allProducts[i]['quantity']
                                                  .toString();

                                              allProducts[i]['quantity'] =
                                                  int.parse(q) + 1;

                                              if (qty == "1") {
                                                cartItems.removeAt(index);
                                              } else {
                                                cartItems[index]['quantity'] =
                                                    int.parse(qty) - 1;
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
