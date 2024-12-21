part of 'order_insights_bloc.dart';

@immutable
sealed class OrderInsightsEvent {}

class GetOrdersEvent extends OrderInsightsEvent {}

class ProcessOrderMetricsEvent extends OrderInsightsEvent {
  final List<Order> orders;

  ProcessOrderMetricsEvent(this.orders);
}

class ProcessOrderTimelineEvent extends OrderInsightsEvent {
  final List<Order> orders;

  ProcessOrderTimelineEvent(this.orders);
}
