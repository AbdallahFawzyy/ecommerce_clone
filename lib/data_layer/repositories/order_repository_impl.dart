import 'package:ecommerce_clone/data_layer/datasources/order_local_data_source/order_local_data_source.dart';
import 'package:ecommerce_clone/domain_layer/entities/order.dart';
import 'package:ecommerce_clone/domain_layer/repositories/order_repository.dart';
import 'package:intl/intl.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource orderLocalDataSource;

  OrderRepositoryImpl({required this.orderLocalDataSource});

  @override
  Future<List<Order>> getOrders() async {
    final orderDTOs = await orderLocalDataSource.getOrders();
    final NumberFormat formatter = NumberFormat.currency(symbol: "\$");
    return orderDTOs
        .map((orderDTO) => Order(
              price: formatter.parse(orderDTO.price).toDouble(),
              registeredAt: DateTime.tryParse(orderDTO.registered) ?? DateTime.now(),
              status: orderDTO.status,
            ))
        .toList();
  }
}
