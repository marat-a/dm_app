import 'package:flutter/material.dart';

import '../model/order.dart';
import '../repository/order_repository.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;
  final OrderRepository _orderController = OrderRepository();

  OrderDetailScreen({super.key, required this.order});

  // void _navigateToEditOrder(BuildContext context, Order order) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => OrderEditScreen(order: order)),
  //   );
  // }

  void _deleteOrder(BuildContext context, Order order) {
    _orderController
        .deleteOrder(order.id!)
        .then((_) => Navigator.pop(context))
        .catchError((error) => print('Не удалось удалить заказ: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заказ № ${order.id}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Сумма: ${order.sum}'),
          // Добавьте другие поля заказа, которые вы хотите отобразить
          // ElevatedButton(
          //   onPressed: () => _navigateToEditOrder(order),
          //   child: Text('Редактировать'),
          // ),
          ElevatedButton(
            onPressed: () => _deleteOrder(context, order),
            child: Text('Удалить'),
          ),
        ],
      ),
    );
  }
}
