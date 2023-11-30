import 'package:dm_app/forms/DateTimePickerPlus.dart';
import 'package:dm_app/model/Customer.dart';
import 'package:dm_app/model/Product.dart';
import 'package:dm_app/model/User.dart';
import 'package:flutter/material.dart';

import '../model/Order.dart';
import '../model/Role.dart';
import '../repository/OrderService.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  late int id;
  late DateTime startTime;
  late DateTime endTime;
  late List<Product> products;
  late double sum;
  late User courier;
  late Customer customer;
  late String commentForCourier;
  late String commentForManager;

  final OrderService _orderService = OrderService();

  @override
  void initState() {
    super.initState();
    id = 0;
    startTime = DateTime.now();
    endTime = DateTime.now();
    products = [];
    sum = 0.0;
    courier = User(name: '', phone: '', role: Role.USER);
    customer = Customer(address: '', orders: [], name: '', phone: '');
    commentForCourier = '';
    commentForManager = '';
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ID'),
                onChanged: (value) {
                  setState(() {
                    id = int.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Start Time'),
                onChanged: (value) {
                  setState(() {
                    startTime = DateTime.parse(value);
                  });
                },
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a start time';
                  }
                  return null;
                },
              ),
              const DateTimePickerPlus(),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'End Time'),
                onChanged: (value) {
                  setState(() {
                    endTime = DateTime.parse(value);
                  });
                },
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a end time';
                  }
                  return null;
                },
              ),
              const DateTimePickerPlus(),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Courier Name'),
                onChanged: (value) {
                  setState(() {
                    courier = User(
                        name: value, phone: courier.phone, role: courier.role);
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a courier name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Customer Name'),
                onChanged: (value) {
                  setState(() {
                    customer = Customer(
                        address: customer.address,
                        orders: customer.orders,
                        name: value,
                        phone: customer.phone);
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a customer name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Order order = Order(
                      id: id,
                      startTime: startTime,
                      endTime: endTime,
                      products: products,
                      sum: sum,
                      courier: courier,
                      customer: customer,
                      commentForCourier: commentForCourier,
                      commentForManager: commentForManager,
                    );
                    _orderService.saveOrder(order).then((success) {
                      if (success) {
                        // Order saved successfully
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Order saved successfully'),
                        ));
                      } else {
                        // Error saving order
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Failed to save order'),
                        ));
                      }
                    });
                  }
                },
                child: const Text('Save Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
