import 'package:ecommerce_clone/domain_layer/entities/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders();
}
