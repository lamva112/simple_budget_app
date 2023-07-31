import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_budget/helpers/color_helper.dart';

import '../models/category_model.dart';
import '../models/expense_model.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double totalAmountSpend = 0;
    for (Expense expense in widget.category.expenses) {
      totalAmountSpend += expense.cost;
    }
    final double amountLeft = widget.category.maxAmount - totalAmountSpend;
    final double percent = amountLeft / widget.category.maxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 6.0),
                  ],
                  borderRadius: BorderRadius.circular(10.0)),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                    bgColor: Colors.grey[200]!,
                    lineColor: getColor(context, percent),
                    percent: percent,
                    width: 15),
                child: Center(
                  child: Text(
                    '\$${amountLeft.toStringAsFixed(2)}/\$${widget.category.maxAmount}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  final Color bgColor;
  final Color lineColor;
  final double width;
  final double percent;

  RadialPainter({
    this.bgColor = Colors.transparent,
    this.lineColor = Colors.transparent,
    this.percent = 0.0,
    this.width = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgLine = Paint()
      ..color = bgColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    // Paint completeLine = Paint()
    //   ..color = lineColor
    //   ..strokeCap = StrokeCap.round
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, bgLine);

    // double sweepAngle = 2 * pi * percent;
    // canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
    //     sweepAngle, false, completeLine);
  }

  @override
  bool shouldRepaint(RadialPainter oldDelegate) =>
      oldDelegate.percent != percent;
}
