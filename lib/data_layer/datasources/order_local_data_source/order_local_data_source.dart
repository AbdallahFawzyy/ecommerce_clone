import 'package:ecommerce_clone/data_layer/models/order/order_dto.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderDto>> getOrders();
}
