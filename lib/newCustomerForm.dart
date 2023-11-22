import 'package:flutter/material.dart';
import 'model/Customer.dart';
import 'model/Order.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  CustomerFormState createState() => CustomerFormState();
}

class CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();

  int id = 0;
  String address = '';
  List<Order> orders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the address';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Customer customer = Customer(
                      address: address,
                      orders: orders,
                      name: '',
                      phone: '',
                    );

                    // Do something with the customer object

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Customer form submitted')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
