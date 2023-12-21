import 'package:flutter/material.dart';

import '../model/order.dart';
import '../repository/order_repository.dart';
import 'order_create_screen.dart';
import 'order_detail_screen.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  OrderListScreenState createState() => OrderListScreenState();
}

class OrderListScreenState extends State<OrderListScreen> {
  List<Order> _orders = [];
  final OrderRepository _orderRepository = OrderRepository();

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      final orders = await _orderRepository.getAllOrders();
      setState(() {
        _orders = orders;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _navigateToOrderDetail(Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailScreen(order: order)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список заказов'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderCreateScreen()),
              );
            },
            child: const Text('Создать заказ'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return ListTile(
            title: Text('Заказ № ${order.id}'),
            subtitle: Text('Сумма: ${order.sum}'),
            onTap: () => _navigateToOrderDetail(order),
          );
        },
      ),
    );
  }
}
