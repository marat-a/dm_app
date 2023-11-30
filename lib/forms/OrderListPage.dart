import 'package:dm_app/repository/OrderService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/Order.dart';
import 'OrderDetailsForm.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  OrderListPageState createState() => OrderListPageState();
}

class OrderListPageState extends State<OrderListPage> {
  late List<Order> orders;

  @override
  void initState() {
    super.initState();
    initializeOrderList();
  }

  void initializeOrderList() {
    OrderService.fetchOrders().then((fetchedOrders) {
      setState(() {
        orders = fetchedOrders;
      });
    }).catchError((error) {
      if (kDebugMode) {
        print('Failed to fetch orders: $error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (orders == null) {
      return const CircularProgressIndicator();
    } else if (orders.isEmpty) {
      return const Text('No orders found');
    } else {
      return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          Order order = orders[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailsForm(order: order),
                ),
              );
            },
            child: ListTile(
              title: Text('ID: ${order.id}'),
              subtitle: Text('Start Time: ${order.startTime}'),
              trailing: const Icon(Icons.arrow_forward),
            ),
          );
        },
      );
    }
  }
}
