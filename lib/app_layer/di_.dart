import 'package:get_it/get_it.dart';

import 'package:ecommerce_clone/data_layer/datasources/order_local_data_source/order_local_data_source.dart';
import 'package:ecommerce_clone/data_layer/datasources/order_local_data_source/order_local_data_source_impl.dart';
import 'package:ecommerce_clone/data_layer/repositories/order_repository_impl.dart';
import 'package:ecommerce_clone/domain_layer/repositories/order_repository.dart';
import 'package:ecommerce_clone/domain_layer/usecases/order_usecases.dart';

final instance = GetIt.instance;

void initLocalDataSources() {
  instance.registerLazySingleton<OrderLocalDataSource>(
      () => OrderLocalDataSourceImpl());
}

void initRepositories() {
  instance.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(orderLocalDataSource: instance()));
}

void initUsecases() {
  instance
      .registerLazySingleton(() => OrderUsecases(orderRepository: instance()));
}
