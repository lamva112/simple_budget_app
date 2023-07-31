import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;

  final List<String> weekLabel = const [
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa'
  ];

  const BarChart({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  ///Method return Bar widget list
  List<Widget> _buildWeekSpendingList() {

    ///Find max element
    double mostExpensive = 0;
    for (double price in expenses) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    }
    ///Create temp list
    List<Widget> weeklySpendingList = [];

    for (int i = 0; i < expenses.length; i++) {
      weeklySpendingList.add(
        Bar(
          label: weekLabel[i],
          amountSpent: expenses[i],
          mostExpensive: mostExpensive,
        ),
      );
    }
    return weeklySpendingList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text(
            'Weekly Spending',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              const Expanded(
                child: Center(
                  child: Text(
                    'Jun 05,2022 - Jun 11, 2022',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _buildWeekSpendingList(),
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxBarHeight = 150;

  const Bar({
    Key? key,
    this.label = '',
    this.amountSpent = 0,
    this.mostExpensive = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Column(
      children: [
        Text(
          '\$${amountSpent.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          height: barHeight,
          width: 18,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6)),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
