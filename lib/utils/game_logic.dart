class Game {
  final String hiddenCardPath = 'assets/images/hidden.png';
  late List<String> gameImg;

  final List<String> cardList = [
    'assets/images/love.png',
    'assets/images/circle.png',
    'assets/images/star.png',
    'assets/images/triangle.png',
    'assets/images/love.png',
    'assets/images/circle.png',
    'assets/images/star.png',
    'assets/images/triangle.png',
  ];

  List<Map<int, String>> matchCheck = [];

  final int cardCount = 8;

  void initGame() {
    gameImg = List.generate(cardCount, (index) => hiddenCardPath);
    cardList.shuffle();
  }
}
