class Question {
  String name;
  String category;
  String url;

  Question(this.name, this.category, this.url);

  static List<Question> generateQuestion() {
    var list = [
      Question("Should All Drugs Be Legalised?", "Law", "assets/drugs.jpeg"),
      Question("Are People Born Evil?", "Social", "assets/evil.jpeg"),
      Question("Is Space Exploration Worth The Cost?", "Science", "assets/spaceex.jpeg"),
      Question("Is Social Justice A Good Model?", "Politics", "assets/socialjustice.jpeg"),
    ];
    list.shuffle();
    return list;
  }

  static List<Question> generateMostPopularBean() {
    return [
      Question("Peach", "Spain ES", "assets/images/bottom1.jpg"),
      Question("Grassland", "Spain ES", "assets/images/bottom2.jpg"),
      Question("Starry sky", "Spain ES", "assets/images/bottom3.jpg"),
      Question("Beauty Pic", "Spain ES", "assets/images/bottom4.jpg"),
    ];
  }
}

class Avatars {
  String name;
  String iconPath;

  Avatars(this.name, this.iconPath);

  static List<Avatars> generateAvatars() {
    var list = [
      Avatars("Test", "assets/icons8-game-controller-48.png"),
      Avatars("Law", "assets/icons8-courthouse-48.png"),
      Avatars("Politics", "assets/icons8-parliament-48.png"),
      Avatars("Science", "assets/icons8-test-tube-48.png"),
      Avatars("Gaming", "assets/icons8-game-controller-48.png"),
      Avatars("Movies", "assets/icons8-cinema-48.png")
    ];
    return list;
  }
}