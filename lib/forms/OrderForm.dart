
import 'package:dm_app/model/Customer.dart';
import 'package:dm_app/model/Product.dart';
import 'package:dm_app/model/User.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
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
  final format = DateFormat('yyyy-MM-dd HH:mm:ss');
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


              const SizedBox(height: 10),

          DateTimeField(
            decoration: const InputDecoration(
              labelText: 'Select Start Date and Time',
              border: OutlineInputBorder(),
            ),
            format: format,
            onChanged: (value) {
              setState(() {
                startTime = value!;
              });
            },
            onShowPicker: (context, currentValue) async {
              final date = await showDatePicker(
                context: context,
                initialDate: currentValue ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );

                // Combine the selected date and time into a DateTime object
                if (time != null) {
                  return DateTimeField.combine(date, time);
                }
              }

              return currentValue;
            },
          ),
              DateTimeField(
                decoration: const InputDecoration(
                  labelText: 'Select End Date and Time',
                  border: OutlineInputBorder(),
                ),
                format: format,
                onChanged: (value) {
                  setState(() {
                    endTime = value!;
                  });
                },
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );

                    // Combine the selected date and time into a DateTime object
                    if (time != null) {
                      return DateTimeField.combine(date, time);
                    }
                  }

                  return currentValue;
                },
              ),
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
