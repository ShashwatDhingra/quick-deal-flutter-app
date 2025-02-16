import 'package:flutter/material.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/utils/ui_utils/constants/colors.dart';

class Sales {
  final String label;
  final double earnings;

  Sales(this.label, this.earnings);
}

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data
    final List<Sales> sales = [
      Sales('Jan', 5000),
      Sales('Feb', 7000),
      Sales('Mar', 3000),
      Sales('Apr', 9000),
      Sales('May', 6000),
      Sales('Jun', 8000),
      Sales('Jul', 4000),
      Sales('Aug', 10000),
      Sales('Sep', 6000),
      Sales('Oct', 9000),
    ];

    final double totalEarnings =
        sales.fold(0, (sum, item) => sum + item.earnings);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CRM Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Bar Chart
              _buildChartCard(
                context,
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(
                      text:
                          'Sales (Total: \$${totalEarnings.toStringAsFixed(2)}'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<Sales, String>>[
                    BarSeries<Sales, String>(
                      dataSource: sales,
                      xValueMapper: (Sales sales, _) => sales.label,
                      yValueMapper: (Sales sales, _) => sales.earnings,
                      name: 'Earnings',
                      color: Colors.blueAccent,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Line Chart
              _buildChartCard(
                context,
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(
                      text:
                          'Sales Earnings (Total: \$${totalEarnings.toStringAsFixed(2)})'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<Sales, String>>[
                    LineSeries<Sales, String>(
                      dataSource: sales,
                      xValueMapper: (Sales sales, _) => sales.label,
                      yValueMapper: (Sales sales, _) => sales.earnings,
                      name: 'Earnings',
                      color: Colors.greenAccent,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Pie Chart
              _buildChartCard(
                context,
                SfCircularChart(
                  title: ChartTitle(
                      text:
                          'Sales Distribution (Total: \$${totalEarnings.toStringAsFixed(2)})'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries<Sales, String>>[
                    PieSeries<Sales, String>(
                      dataSource: sales,
                      xValueMapper: (Sales sales, _) => sales.label,
                      yValueMapper: (Sales sales, _) => sales.earnings,
                      name: 'Earnings',
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      explode: true,
                      explodeIndex: 0,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Column Chart
              _buildChartCard(
                context,
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(
                      text:
                          'Sales Earnings (Total: \$${totalEarnings.toStringAsFixed(2)})'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<Sales, String>>[
                    ColumnSeries<Sales, String>(
                      dataSource: sales,
                      xValueMapper: (Sales sales, _) => sales.label,
                      yValueMapper: (Sales sales, _) => sales.earnings,
                      name: 'Earnings',
                      color: Colors.orangeAccent,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard(BuildContext context, Widget chart) {
    var isDark = context.isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? CColors.darkContainer : CColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: CColors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: chart,
      ),
    );
  }
}

final List<Sales> sales = [
  Sales('Jan', 5000),
  Sales('Feb', 7000),
  Sales('Mar', 3000),
  Sales('Apr', 8000),
  Sales('May', 6000),
  Sales('Jun', 9000),
  Sales('Jul', 4000),
  Sales('Aug', 7500),
  Sales('Sep', 8500),
  Sales('Oct', 9500),
  Sales('Nov', 10000),
  Sales('Dec', 12000),
];

final double totalEarnings = sales.fold(0, (sum, sale) => sum + sale.earnings);
