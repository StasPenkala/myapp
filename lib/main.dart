import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
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
  String _output = "0";
  String _operand = "";
  double _num1 = 0;
  double _num2 = 0;
  List<String> _history = [];
  String _memeMessage = "";

  Map<String, String> _numberMemes = {
    '10': 'Розмір не головне, головне як використовувати!',
    '42': 'Відповідь на все, що ти шукаєш.',
    '69': 'Це не просто число, це стиль!',
    '100': 'Здається, тебе чекає робота з трактором!',
    '1941': 'Діло було в 41-му році, німців було повно-повно...',
    '500': 'Коли навіть калькулятор не витримує.',
    '666': 'Ось це вже демонічно!',
    '777': 'Коли у тебе всі шанси на удачу!',
    '2000': 'Це більше ніж ти думав!',
    '2024': 'Нас чекає світле майбутнє!',
    '2025': 'Ось вже й майбутнє настало!',
    '300' : 'Ех. зараз би стати трактористом',
    '1' : '1 квітня твій день',
    '404' : 'EROR',
    '13' : 'Я не забобонний, але 13 завжди підозріло',
    '90' : '90-60-90 мені б жінку з такими параметрами',
    '60' : '90-60-90 мені б жінку з такими параметрами',
    '1000' : 'якось я дав 1000 чоловіку з туреччини, тепер це штука турка',
    '8' : 'що стаказала цифра 0 цифрі 8? Класний пояс',
    '' : '',
  };

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _operand = "";
        _num1 = 0;
        _num2 = 0;
        _memeMessage = "";
      } else if (buttonText == "⌫") {
        _output = _output.length > 1 ? _output.substring(0, _output.length - 1) : "0";
        _memeMessage = "";
      } else if (buttonText == "%") {
        _output = (double.parse(_output) / 100).toString();
        _memeMessage = "";
      } else if (buttonText == "=" && _operand.isNotEmpty) {
        _num2 = double.parse(_output);

        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "×":
            _output = (_num1 * _num2).toString();
            break;
          case "÷":
            _output = (_num2 != 0 ? (_num1 / _num2).toString() : "Error");
            break;
        }

        _history.add("$_num1 $_operand $_num2 = $_output");
        _operand = "";
        _num1 = 0;
        _num2 = 0;

        // Генерація мемів для чисел
        _memeMessage = _numberMemes[_output] ?? "";
      } else if (["+", "-", "×", "÷"].contains(buttonText)) {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _output = "0";
        _memeMessage = "";
      } else if (buttonText == "." && !_output.contains(".")) {
        // Додаємо десяткову точку, якщо її ще немає
        _output = _output + ".";
      } else {
        _output = _output == "0" ? buttonText : _output + buttonText;
        _memeMessage = "";
      }
    });
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          color: Colors.black,
          child: ListView.builder(
            itemCount: _history.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                _history[index],
                style: TextStyle(color: Colors.greenAccent, fontSize: 18),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildButton({
    String? text,
    Color textColor = Colors.white,
    Color bgColor = Colors.black,
    VoidCallback? onPressed,
    Widget? child,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
          ),
          onPressed: onPressed ?? () => _buttonPressed(text!),
          child: child ?? Text(
            text!,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: _output.contains('.') ? 32 : 40,  // Збільшуємо шрифт для результату
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  if (_memeMessage.isNotEmpty)
                    Text(
                      _memeMessage,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.greenAccent,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton(text: "C", textColor: Colors.black, bgColor: Colors.greenAccent),
                  _buildButton(text: "⌫", textColor: Colors.greenAccent, bgColor: Colors.black),
                  _buildButton(text: "%", textColor: Colors.greenAccent, bgColor: Colors.black),
                  _buildButton(text: "÷", textColor: Colors.greenAccent, bgColor: Colors.black),
                ],
              ),
              Row(
                children: [
                  _buildButton(text: "7"),
                  _buildButton(text: "8"),
                  _buildButton(text: "9"),
                  _buildButton(text: "×", textColor: Colors.greenAccent, bgColor: Colors.black),
                ],
              ),
              Row(
                children: [
                  _buildButton(text: "4"),
                  _buildButton(text: "5"),
                  _buildButton(text: "6"),
                  _buildButton(text: "-", textColor: Colors.greenAccent, bgColor: Colors.black),
                ],
              ),
              Row(
                children: [
                  _buildButton(text: "1"),
                  _buildButton(text: "2"),
                  _buildButton(text: "3"),
                  _buildButton(text: "+", textColor: Colors.greenAccent, bgColor: Colors.black),
                ],
              ),
              Row(
                children: [
                  _buildButton(text: "0"),
                  _buildButton(text: ".", textColor: Colors.white, bgColor: Colors.black),
                  _buildButton(child: Icon(Icons.history, color: Colors.white), onPressed: _showHistory),
                  _buildButton(text: "=", textColor: Colors.black, bgColor: Colors.greenAccent),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
