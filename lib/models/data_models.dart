import 'package:flutter/material.dart';

class ServiceCategory {
  final String name;
  final IconData icon;
  final List<Service> services;

  ServiceCategory({
    required this.name,
    required this.icon,
    required this.services,
  });
}

class Service {
  final String name;
  final String price;
  final String description;

  Service({required this.name, required this.price, required this.description});
}
