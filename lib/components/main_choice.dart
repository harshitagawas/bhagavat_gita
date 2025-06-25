import 'package:flutter/material.dart';

class Choice extends StatefulWidget {
  final IconData icon;
  final String label;
  final int border;
  final Widget route;

  const Choice({
    super.key,
    required this.icon,
    required this.label,
    required this.border,
    required this.route,
  });

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>widget.route));
      },
      child: Container(
        height: 150,
        width: 150,

        decoration: (widget.border == 1)
            ? BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(50),
                  bottomStart: Radius.circular(50),
                ),
                color: Color(0xFFf5b400),
              )
            : BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(50),
                  bottomEnd: Radius.circular(50),
                ),
                color: Color(0xFFc86d3c),
              ),
      
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 40),
              const SizedBox(height: 20),
              Text(widget.label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
