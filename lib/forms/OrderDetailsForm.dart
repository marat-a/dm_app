import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dm_app/model/Order.dart';
import 'package:dm_app/model/Product.dart';

class OrderDetailsForm extends StatelessWidget {
  final Order order;

  const OrderDetailsForm({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${order.id}'),
            const SizedBox(height: 10),
            Text('Start Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(order.startTime)}'),
            const SizedBox(height: 10),
            Text('End Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(order.endTime)}'),
            const SizedBox(height: 10),
            const Text('Products:'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: order.products.length,
              itemBuilder: (context, index) {
                Product product = order.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: ${product.price}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}