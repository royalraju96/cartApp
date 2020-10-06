// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:diagnostic_app/data/cartData.dart';
// import 'package:diagnostic_app/data/productData.dart';
// import 'package:diagnostic_app/models/cartModels.dart';
// import 'package:flutter/material.dart';

// class CartTile extends StatelessWidget {
//   final DiagonistcsData cartProduct;

//   CartTile(this.cartProduct);

//   @override
//   Widget build(BuildContext context) {
//     Widget _buildContent() {
//       return Row(
//         children: <Widget>[
//           // Container(
//           //   padding: EdgeInsets.all(8),
//           //   width: 150,
//           //   child: Image.network(
//           //     cartProduct.diagonisticsProduct.images[0],
//           //     fit: BoxFit.cover,
//           //   ),
//           // ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(8),
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     cartProduct.diagonisticsProduct.test,
//                     style: TextStyle(
//                       fontFamily: 'Merriweather',
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[900],
//                     ),
//                   ),
//                   // Text(
//                   //   'Tamanho ${cartProduct.size}',
//                   //   style: TextStyle(
//                   //     fontFamily: 'Roboto',
//                   //     fontSize: 16,
//                   //     fontWeight: FontWeight.bold,
//                   //     color: Colors.grey[600],
//                   //   ),
//                   // ),
//                   Text(
//                     'R\$ ${cartProduct.diagonisticsProduct.mrp.toStringAsFixed(2)}',
//                     style: TextStyle(
//                       fontFamily: 'Roboto',
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.amber,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(Icons.remove, color: Colors.amber),
//                         onPressed: cartProduct.qty > 1
//                             ? () {
//                                 CartModel.of(context).decProduct(cartProduct);
//                               }
//                             : null,
//                       ),
//                       Text(cartProduct.qty.toString()),
//                       IconButton(
//                         icon: Icon(Icons.add, color: Colors.amber),
//                         onPressed: () {
//                           CartModel.of(context).incProduct(cartProduct);
//                         },
//                       ),
//                       FlatButton(
//                         child: Text(
//                           'Remover',
//                           style: TextStyle(
//                             fontFamily: 'Merriweather',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey[500],
//                           ),
//                         ),
//                         onPressed: () {
//                           CartModel.of(context).removeCartItem(cartProduct);
//                         },
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       );
//     }

//     return Card(
//         margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         child: cartProduct.diagonisticsProduct == null
//             ? FutureBuilder<DocumentSnapshot>(
//                 future: Firestore.instance
//                     .collection('products')
//                     .document(cartProduct.id)
//                     .collection('products')
//                     .document(cartProduct.test)
//                     .get(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     cartProduct.diagonisticsProduct =
//                         DiagonisticsProduct.fromDocument(snapshot.data);
//                     return _buildContent();
//                   } else {
//                     return Container(
//                       height: 100,
//                       child: CircularProgressIndicator(),
//                       alignment: Alignment.center,
//                     );
//                   }
//                 },
//               )
//             : _buildContent());
//   }
// }
