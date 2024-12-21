part of 'order_insights_bloc.dart';

@immutable
sealed class OrderInsightsState {}

final class OrderInsightsInitial extends OrderInsightsState {}

final class OrderInsightsLoading extends OrderInsightsState {}

final class OrderMetricsLoaded extends OrderInsightsState {}

final class OrderTimelineLoaded extends OrderInsightsState {}
