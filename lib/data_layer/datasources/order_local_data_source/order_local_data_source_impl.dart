import 'dart:convert';

import 'package:ecommerce_clone/data_layer/datasources/order_local_data_source/order_local_data_source.dart';
import 'package:ecommerce_clone/data_layer/models/order/order_dto.dart';
import 'package:flutter/services.dart';

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  @override
  Future<List<OrderDto>> getOrders() async {
    final jsonString = await rootBundle.loadString('assets/orders.json');
    final jsonMap = json.decode(jsonString) as List;
    return jsonMap.map((json) => OrderDto.fromJson(json)).toList();
  }
}
