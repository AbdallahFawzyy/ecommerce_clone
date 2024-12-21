import 'package:ecommerce_clone/presentation_layer/order_insights_screen/bloc/order_insights_bloc.dart';
import 'package:ecommerce_clone/presentation_layer/widgets/keep_alive_widget.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_clone/presentation_layer/order_graph_view/order_graph_view.dart';
import 'package:ecommerce_clone/presentation_layer/order_metrics_view/order_metrics_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderInsightsScreen extends StatefulWidget {
  const OrderInsightsScreen({super.key});

  @override
  State<OrderInsightsScreen> createState() => _OrderInsightsScreenState();
}

class _OrderInsightsScreenState extends State<OrderInsightsScreen> {
  late OrderInsightsBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<OrderInsightsBloc>(context);
    _bloc.add(GetOrdersEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Insights', style: Theme.of(context).textTheme.titleLarge),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Metrics', icon: Icon(Icons.analytics)),
              Tab(text: 'Graph', icon: Icon(Icons.bar_chart)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            KeepAliveWidget(child: _buildOrderMetricsView()),
            KeepAliveWidget(child: _buildOrderGraphView()),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderMetricsView() {
    return BlocBuilder<OrderInsightsBloc, OrderInsightsState>(
      bloc: _bloc,
      buildWhen: (previous, current) => current is OrderMetricsLoaded,
      builder: (context, state) {
        if (state is OrderMetricsLoaded) {
          return OrderMetricsView(
            totalCount: _bloc.totalOrders,
            averagePrice: _bloc.averagePrice,
            numberOfReturns: _bloc.numberOfReturns,
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildOrderGraphView() {
    return BlocBuilder<OrderInsightsBloc, OrderInsightsState>(
      bloc: _bloc,
      buildWhen: (previous, current) => current is OrderTimelineLoaded,
      builder: (context, state) {
        if (state is OrderTimelineLoaded) {
          return OrderGraphView(dates: _bloc.dates);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
