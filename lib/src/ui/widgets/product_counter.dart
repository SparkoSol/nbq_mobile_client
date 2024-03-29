import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductQtyCounter extends StatefulWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final ValueChanged<int> onChanged;

  ProductQtyCounter({
    this.quantity = 0,
    this.onChanged,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  _ProductQtyCounterState createState() => _ProductQtyCounterState();
}

class _ProductQtyCounterState extends State<ProductQtyCounter> {
  int _qty;

  @override
  void initState() {
    super.initState();
  }

  void _increment() {
    widget.onChanged?.call(++_qty);
    widget.onIncrement?.call();
  }

  void _decrement() {
    widget.onChanged?.call(--_qty);
    widget.onDecrement?.call();
  }

  void _incrementAction() => setState(_increment);

  void _decrementAction() {
    if (_qty > 0) setState(_decrement);
  }

  @override
  Widget build(BuildContext context) {
    _qty = widget.quantity;
    final style = TextButton.styleFrom(
      primary: Colors.black,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(),
      backgroundColor: Colors.transparent,
    );

    return Center(
      child: Container(
        width: 90,
        height: 25,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 1),
          ],
        ),
        child: Row(children: [
          SizedBox(
            width: 25,
            child: TextButton(
              style: style,
              onPressed: _decrementAction,
              child: Icon(FontAwesomeIcons.minus, size: 10),
            ),
          ),
          VerticalDivider(indent: 5, endIndent: 5, thickness: 1.5, width: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              width: 30,
              child: Text(
                _qty.toString(),
                style: GoogleFonts.bebasNeue(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          VerticalDivider(indent: 5, endIndent: 5, thickness: 1.5, width: 0),
          SizedBox(
            width: 25,
            child: TextButton(
              style: style,
              onPressed: _incrementAction,
              child: Icon(FontAwesomeIcons.plus, size: 10),
            ),
          ),
        ]),
      ),
    );
  }
}
