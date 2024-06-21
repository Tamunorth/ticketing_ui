import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ticket_painter.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    super.key,
    required this.sizeAnimation,
  });

  final Animation<double> sizeAnimation;

  static const double width = 410;
  static const double height = 350;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(width, height),
            painter: TicketPainter(Colors.red),
          ),
          Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TicketColumn(
                          title: 'IAMX',
                          subtitle: 'Electronic',
                        ),
                        TicketColumn(
                          title: 'Boniva',
                          subtitle: 'California',
                          alignment: CrossAxisAlignment.end,
                        ),
                      ],
                    ),
                    SizedBox(height: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TicketColumn(
                          title: 'R1, S31',
                          subtitle: 'Amphitheater',
                        ),
                        TicketColumn(
                          title: '10:20',
                          subtitle: 'Sun, 22 Nov',
                          alignment: CrossAxisAlignment.end,
                        ),
                      ],
                    ),
                  ],
                ),
                SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: sizeAnimation,
                  child: BarcodeWidget(
                    barcode: Barcode.code128(), // Choose the barcode type
                    data: '1234567890', // The data to be encoded in the barcode
                    width: width - 20,
                    height: 50,
                    color: Colors.white,
                    drawText: false, // Show the text below the barcode
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TicketColumn extends StatelessWidget {
  const TicketColumn({
    super.key,
    required this.title,
    required this.subtitle,
    this.alignment,
  });

  final String title;
  final String subtitle;
  final CrossAxisAlignment? alignment;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}
