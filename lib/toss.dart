import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import 'AudioManager.dart';
class TossScreen extends StatefulWidget {
  @override
  State<TossScreen> createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen> {
  bool flipped=false;

  String selection="";
  String result="";
  bool wonToss=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.brown ,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.brown[800],
        title: const Text('T  oss',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Soul_Calibur',
              fontSize: 40
          ),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            ClipOval(
              child: GestureDetector(
                onTap: (){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select Heads or Tails.'),
                    ),
                  );
                },
                child: FlipCard(
                  direction: FlipDirection.VERTICAL,
                  speed: 1000,
                  flipOnTouch: (selection=="")?false:true,
                  onFlip: (){AudioManager.coinSound();

                    result="";
                  },
                  onFlipDone: (status) {
                    wonToss=(result==selection)?true:false;
                    Future.delayed(const Duration(milliseconds: 800), () {
                      alertMessage();
                    });
                    setState(() {
                      result=flipCoin();
                      flipped=true;
                    });
                  },
                  front: CoinSide(text: !flipped?'Flip':result, color: Colors.orange),
                  back: CoinSide(text: result, color: Colors.yellow),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width:130,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        await AudioManager.clickSound();


                        setState(() {
                          selection = "Heads";

                        });
                      },
                    style: ElevatedButton.styleFrom(

                      backgroundColor: selection == "Heads" ? Colors.brown[800] : null,
                    ),
                    child: Text(
                      'Heads',
                      style: TextStyle(
                          fontFamily: 'CombackHome',
                          fontSize: 35
                      ),

                    ),

                  ),
                ),
                SizedBox(width: 50,),
                SizedBox(
                  width:130,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await AudioManager.clickSound();
                      setState(() {
                        selection = "Tails";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selection == "Tails" ? Colors.brown[800] : null,
                    ),
                    child: Text(
                        'Tails',
                      style: TextStyle(
                        fontFamily: 'CombackHome',
                        fontSize: 35
                      ),

                    ),

                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
  void alertMessage(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(result==selection?'You won the toss':'You lost the toss'),
          content: const Text('Select Proceed to start the game'),
          actions: [
            TextButton(
              onPressed: () async {
                await AudioManager.clickSound();
                Navigator.of(context).pop();
                Navigator.pop(context);
                Navigator.pop(context);


              },
              child: const Text('Home Screen'),
            ),
            TextButton(
              onPressed: () async {
                await AudioManager.clickSound();
                setState(() {
                });
                Navigator.of(context).pop();
                AudioManager.startSound();
                Navigator.pushNamed(context, '/human',arguments: {
                  'ai':true,'wonToss':result==selection,
                });
              },
              child: const Text('Proceed'),
            )
          ],
        );
      },
    );
  }

  String flipCoin() {
    final Random random = Random();
    return random.nextBool() ? 'Heads' : 'Tails';
  }
}


class CoinSide extends StatelessWidget {
  final String text;
  final Color color;

  CoinSide({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, fontFamily: 'CombackHome'),
        ),
      ),
    );
  }
}