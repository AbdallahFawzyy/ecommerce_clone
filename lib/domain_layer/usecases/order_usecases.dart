import 'package:ecommerce_clone/domain_layer/entities/order.dart';
import 'package:ecommerce_clone/domain_layer/repositories/order_repository.dart';

class OrderUsecases {
  final OrderRepository orderRepository;

  OrderUsecases({required this.orderRepository});

  Future<List<Order>> getOrders() async {
    return orderRepository.getOrders();
  }
}
