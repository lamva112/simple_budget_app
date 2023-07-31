import 'package:flutter/material.dart';
import 'package:simple_budget/data/data.dart';
import 'package:simple_budget/helpers/color_helper.dart';
import 'package:simple_budget/models/expense_model.dart';
import 'package:simple_budget/screens/category_screen.dart';
import 'package:simple_budget/widgets/bar_chart.dart';
import 'package:simple_budget/widgets/footer_widget.dart';

import '../models/category_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            forceElevated: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Simple Budget'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://c4.wallpaperflare.com/wallpaper/586/603/742/minimalism-4k-for-mac-desktop-wallpaper-preview.jpg",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black12, Colors.transparent])),
                  )
                ],
              ),
            ),
            leading: IconButton(
              iconSize: 30.0,
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: const Icon(Icons.add),
              )
            ],
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(0, 2),
                            blurRadius: 6.0),
                      ],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: BarChart(
                    expenses: weeklySpending,
                  ),
                );
              } else {
                final Category category = categories[index - 1];
                double totalAmountSpend = 0;
                for (Expense expense in category.expenses) {
                  totalAmountSpend += expense.cost;
                }

                return _buildCategory(context, category, totalAmountSpend);
              }
            }, childCount: categories.length + 1),
          ),
          const SliverToBoxAdapter(
            child: FooterWidget(),
          )
        ],
      ),
    );
  }

  Widget _buildCategory(
      BuildContext context, Category category, double totalAmountSpend) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CategoryScreen(
                  category: category,
                )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 2), blurRadius: 6.0),
            ],
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                    '\$${totalAmountSpend.toStringAsFixed(2)}/${category.maxAmount}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpend) /
                    category.maxAmount;
                double barWidth = percent * maxBarWidth;
                if (barWidth < 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    Container(
                      width: barWidth,
                      height: 20,
                      decoration: BoxDecoration(
                          color: getColor(context, percent),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
