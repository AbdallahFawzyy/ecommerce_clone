import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OrderMetricsView extends StatefulWidget {
  final int totalCount;
  final double averagePrice;
  final int numberOfReturns;

  const OrderMetricsView({
    super.key,
    required this.totalCount,
    required this.averagePrice,
    required this.numberOfReturns,
  });

  @override
  State<OrderMetricsView> createState() => _OrderMetricsViewState();
}

class _OrderMetricsViewState extends State<OrderMetricsView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: ResponsiveGridView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          gridDelegate: const ResponsiveGridDelegate(
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            maxCrossAxisExtent: 300,
          ),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return _buildMetricCard(
                  title: "Total Orders",
                  value: "${widget.totalCount}",
                  icon: Icons.shopping_cart,
                  color: Colors.blue,
                );
              case 1:
                return _buildMetricCard(
                  title: "Avg. Price",
                  value: "\$${widget.averagePrice.toStringAsFixed(2)}",
                  icon: Icons.attach_money,
                  color: Colors.green,
                );
              case 2:
                return _buildMetricCard(
                  title: "Returns",
                  value: "${widget.numberOfReturns}",
                  icon: Icons.refresh,
                  color: Colors.red,
                );
              default:
                return Container();
            }
          },
          itemCount: 3,
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
