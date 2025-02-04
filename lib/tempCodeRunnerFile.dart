import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zachary Lerner\'s Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _calculateResult() {
    try {
      final expression = Expression.parse(_expression);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  void _square() {
    setState(() {
      final expression = Expression.parse(_expression);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      final squaredResult = result * result;
      _expression = squaredResult.toString();
      _result = squaredResult.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zachary Lerner\'s Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16),
              child: Text(
                '$_expression = $_result',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Divider(height: 1),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: [
              CalculatorButton(
                text: '7',
                onPressed: () => _addToExpression('7'),
              ),
              CalculatorButton(
                text: '8',
                onPressed: () => _addToExpression('8'),
              ),
              CalculatorButton(
                text: '9',
                onPressed: () => _addToExpression('9'),
              ),
              CalculatorButton(
                text: '/',
                onPressed: () => _addToExpression('/'),
              ),
              CalculatorButton(
                text: '4',
                onPressed: () => _addToExpression('4'),
              ),
              CalculatorButton(
                text: '5',
                onPressed: () => _addToExpression('5'),
              ),
              CalculatorButton(
                text: '6',
                onPressed: () => _addToExpression('6'),
              ),
              CalculatorButton(
                text: '*',
                onPressed: () => _addToExpression('*'),
              ),
              CalculatorButton(
                text: '1',
                onPressed: () => _addToExpression('1'),
              ),
              CalculatorButton(
                text: '2',
                onPressed: () => _addToExpression('2'),
              ),
              CalculatorButton(
                text: '3',
                onPressed: () => _addToExpression('3'),
              ),
              CalculatorButton(
                text: '-',
                onPressed: () => _addToExpression('-'),
              ),
              CalculatorButton(
                text: '0',
                onPressed: () => _addToExpression('0'),
              ),
              CalculatorButton(
                text: '.',
                onPressed: () => _addToExpression('.'),
              ),
              CalculatorButton(
                text: '=',
                onPressed: _calculateResult,
              ),
              CalculatorButton(
                text: '+',
                onPressed: () => _addToExpression('+'),
              ),
              CalculatorButton(
                text: 'C',
                onPressed: _clearExpression,
              ),
              CalculatorButton(
                text: 'x²',
                onPressed: _square,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}