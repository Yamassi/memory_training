import 'package:flutter/material.dart';
import 'package:memory_training/widgets/score_board.dart';
import 'utils/game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tries = 0;
  int score = 0;
  int openCardCount = 0;
  Game _game = Game();

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    List imgList = _game.gameImg;
    List check = _game.matchCheck;

    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Тренировка памяти',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  scoreBoard('Попытки', '$tries'),
                  scoreBoard('Счет', '$score'),
                ],
              ),
            ),
            SizedBox(
              height: screen_width,
              width: screen_width,
              child: GridView.builder(
                  itemCount: _game.gameImg.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          imgList[index] = _game.cardList[index];
                          check.add({index: _game.cardList[index]});
                          print(openCardCount);
                        });
                        if (check.length == 2) {
                          tries++;
                          if (check[0].values.first == check[1].values.first) {
                            match();
                          } else {
                            notMatch();
                          }
                        }
                        if (openCardCount >= 8) {
                          resetCards();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          image: DecorationImage(
                            image: AssetImage(
                              imgList[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void notMatch() {
    print('Не совпало!');
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _game.gameImg[_game.matchCheck[0].keys.first] = _game.hiddenCardPath;
        _game.gameImg[_game.matchCheck[1].keys.first] = _game.hiddenCardPath;
        _game.matchCheck.clear();
      });
    });
  }

  void match() {
    print('Совпало!');
    score += 100;
    _game.matchCheck.clear();
    openCardCount += 2;
  }

  void resetCards() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        print('Сброс');
        for (var i = 0; i < _game.gameImg.length; i++) {
          _game.gameImg[i] = _game.hiddenCardPath;
        }
        _game.matchCheck.clear();
        openCardCount = 0;
        _game.cardList.shuffle();
      });
    });
  }
}
