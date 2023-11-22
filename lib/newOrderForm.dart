import 'package:flutter/material.dart';

import 'controllers/orderController.dart';
import 'model/Customer.dart';
import 'model/delivery.dart';
import 'model/Order.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  OrderController? _controller;
  int? id;
  Customer customer = Customer(address: '', orders: [], name: '', phone: '');
  String transferType = '';
  Delivery delivery =
      Delivery(deliveryTime: DateTime.now(), comment: '', address: '', cost: null);
  String? status = '';
  String orderComment = '';
  String? payStatus = '';
  String? receivingType = '';
  double sum = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Transfer Type',
                  ),
                  onSaved: (value) {
                    transferType = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Status',
                  ),
                  onSaved: (value) {
                    status = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Order Comment',
                  ),
                  onSaved: (value) {
                    orderComment = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Pay Status',
                  ),
                  onSaved: (value) {
                    payStatus = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Receiving Type',
                  ),
                  onSaved: (value) {
                    receivingType = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Sum',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    sum = double.parse(value!);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      Order order = Order(
                        id: id,
                        customer: customer,
                        transferType: transferType,
                        delivery: delivery,
                        status: status,
                        orderComment: orderComment,
                        payStatus: payStatus,
                        receivingType: receivingType,
                        sum: sum,
                      );


                        _controller!.editOrder(order, (status) {
                          if (status is OrderUpdateSuccess) {
                            Navigator.pop(context, order);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Ошибка при изменении заказа")));
                          }
                        });
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order form submitted')),
                      );
                    }
                  ,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
