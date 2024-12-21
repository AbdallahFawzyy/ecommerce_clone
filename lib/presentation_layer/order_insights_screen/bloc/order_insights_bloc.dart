import 'package:ecommerce_clone/app_layer/di_.dart';
import 'package:ecommerce_clone/domain_layer/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_clone/domain_layer/usecases/order_usecases.dart';

part 'order_insights_event.dart';
part 'order_insights_state.dart';

class OrderInsightsBloc extends Bloc<OrderInsightsEvent, OrderInsightsState> {
  late int totalOrders;
  late double averagePrice;
  late int numberOfReturns;
  late List<DateTime> dates;
  late OrderUsecases _orderUsecases;

  OrderInsightsBloc() : super(OrderInsightsInitial()) {
    totalOrders = 0;
    averagePrice = 0;
    numberOfReturns = 0;
    dates = [];
    _orderUsecases = instance<OrderUsecases>();

    on<GetOrdersEvent>(_onGetOrdersEvent);
    on<ProcessOrderMetricsEvent>(_onProcessOrderMetricsEvent);
    on<ProcessOrderTimelineEvent>(_onProcessOrderGraphEvent);
  }

  Future<void> _onGetOrdersEvent(GetOrdersEvent event, Emitter<OrderInsightsState> emit) async {
    emit(OrderInsightsLoading());

    final orders = await _orderUsecases.getOrders();

    add(ProcessOrderMetricsEvent(orders));
    add(ProcessOrderTimelineEvent(orders));
  }

  Future<void> _onProcessOrderMetricsEvent(ProcessOrderMetricsEvent event, Emitter<OrderInsightsState> emit) async {
    final orders = event.orders;

    totalOrders = orders.length;
    averagePrice = orders.map((order) => order.price).reduce((a, b) => a + b);
    numberOfReturns = orders.where((order) => order.status == "RETURNED").length;

    emit(OrderMetricsLoaded());
  }

  Future<void> _onProcessOrderGraphEvent(ProcessOrderTimelineEvent event, Emitter<OrderInsightsState> emit) async {
    final orders = event.orders;

    dates = orders.map((order) => order.registeredAt).toList();

    emit(OrderTimelineLoaded());
  }

  int get getTotalOrders => totalOrders;
  double get getAveragePrice => averagePrice;
  int get getNumberOfReturns => numberOfReturns;
  List<DateTime> get getDates => dates;
}
