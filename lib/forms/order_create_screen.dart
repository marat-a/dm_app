import 'dart:convert';

import 'package:dm_app/enums/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:http/http.dart' as http;

import '../enums/delivery_type.dart';
import '../enums/pay_status.dart';
import '../enums/progress_status.dart';
import '../model/customer.dart';
import '../model/order.dart';
import '../model/user.dart';
import '../model/delivery_info.dart';
import '../model/product.dart';
import '../repository/order_repository.dart';

class OrderCreateScreen extends StatefulWidget {
  const OrderCreateScreen({super.key});

  @override
  OrderCreateScreenState createState() => OrderCreateScreenState();
}


class OrderCreateScreenState extends State<OrderCreateScreen> {
  final TextEditingController _sumController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _deliveryInfoController = TextEditingController();
  final TextEditingController _productsController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  PayStatus _payStatus = PayStatus.UNPAID;
  final List<PayStatus> _payStatusOptions = PayStatus.values.toList();
  ProgressStatus _progressStatus = ProgressStatus.NOTAPPROVED;
  final List<ProgressStatus> _progressStatusOptions = ProgressStatus.values.toList();
  late List<Product> _products = [];
  Product? _selectedProduct;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  final TextEditingController _deliveryCommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  final OrderRepository _orderController = OrderRepository();

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse('https://92.118.113.20/products'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        _products = responseData.map((json) => Product.fromJson(json)).toList();
      });
    }
  }

  void _createOrder() {
    final double sum = double.parse(_sumController.text);
    final double paid = double.parse(_paidController.text);
    final String comment = _commentController.text;

    final deliveryInfo = DeliveryInfo(
      id: 0,
      startTime: startTime,
      endTime: endTime,
      courier: User(id: 0, name: '', phone: '', role: Role.USER ),
      deliveryType: DeliveryType.DELIVERY, // Замените на фактическое значение
      deliveryComment: _deliveryCommentController.text,
    );

    final Customer customer = Customer.fromJson(jsonDecode(_customerController.text));


    final order = Order(
      id: 0,
      deliveryInfo: deliveryInfo,
      products: [_selectedProduct!],
      sum: sum,
      paid: paid,
      payStatus: _payStatus,
      progressStatus: _progressStatus,
      customer: customer,
      commentForManager: comment,
    );

    _orderController
        .createOrder(order)
        .then((_) => Navigator.pop(context))
        .catchError((error) => throw Exception('Не удалось удалить заказ: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание заказа'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _sumController,
              decoration: const InputDecoration(
                labelText: 'Сумма',
              ),
            ),
            TextField(
              controller: _paidController,
              decoration: const InputDecoration(
                labelText: 'Оплачено',
              ),
            ),
        TextButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2020, 3, 5),
                  maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                    setState(() {
                      startTime = date;
                    });
                  }, onConfirm: (date) {
                    setState(() {
                      startTime = date;
                    });
                  }, currentTime: startTime, locale: LocaleType.ru);
            },
            child: const Text(
              'Выберите время начала',
              style: TextStyle(color: Colors.blue),
            )),
            TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                        setState(() {
                          endTime = date;
                        });
                      }, onConfirm: (date) {
                        setState(() {
                          endTime = date;
                        });

                      }, currentTime: endTime, locale: LocaleType.ru);
                },
                child: const Text(
                  'Выберите время окончания',
                  style: TextStyle(color: Colors.blue),
                )),
            DropdownButton<Product>(
              value: _selectedProduct,
              hint: const Text('Выберите товар'),
              onChanged: (Product? selectedProduct) {
                setState(() {
                  _selectedProduct = selectedProduct;
                });
              },
              items: _products.map<DropdownMenuItem<Product>>((Product product) {
                return DropdownMenuItem<Product>(
                  value: product,
                  child: Text(product.name),
                );
              }).toList(),
            ),
            DropdownButton<PayStatus>(
              value: _payStatus,
              onChanged: (PayStatus? value) {
                setState(() {
                  _payStatus = value!;
                });
              },
              items: _payStatusOptions.map<DropdownMenuItem<PayStatus>>((PayStatus value) {
                return DropdownMenuItem<PayStatus>(
                  value: value,
                  child: Text(value.toString().split('.')[1]), // Отображение имени значения enum
                );
              }).toList(),
            ),
            DropdownButton<ProgressStatus>(
              value: _progressStatus,
              onChanged: (ProgressStatus? value) {
                setState(() {
                  _progressStatus = value!;
                });
              },
              items: _progressStatusOptions.map<DropdownMenuItem<ProgressStatus>>((ProgressStatus value) {
                return DropdownMenuItem<ProgressStatus>(
                  value: value,
                  child: Text(value.toString().split('.')[1]),
                );
              }).toList(),
            ),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Комментарий для менеджера',
              ),
            ),

            TextField(
              controller: _deliveryInfoController,
              decoration: const InputDecoration(
                labelText: 'Информация о доставке',
              ),
            ),
            TextField(
              controller: _productsController,
              decoration: const InputDecoration(
                labelText: 'Список товаров',
              ),
            ),
            TextField(
              controller: _customerController,
              decoration: const InputDecoration(
                labelText: 'Покупатель',
              ),
            ),
            ElevatedButton(
              onPressed: _createOrder,
              child: const Text('Создать заказ'),
            ),
          ],
        ),
      ),
    );
  }
}
