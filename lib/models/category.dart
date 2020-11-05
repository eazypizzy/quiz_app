class Category {
  List<TriviaCategories> triviaCategories;

  Category({this.triviaCategories});

  Category.fromJson(Map<String, dynamic> json) {
    if (json['trivia_categories'] != null) {
      triviaCategories = List<TriviaCategories>();
      json['trivia_categories'].forEach((v) {
        triviaCategories.add(TriviaCategories.fromJson(v));
      });
    }
  }
  @override
  String toString() {
    return '${triviaCategories.first.toString()}';
  }
}

class TriviaCategories {
  int id;
  String name;
  bool click = false;

  TriviaCategories({this.id, this.name});

  TriviaCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  @override
  String toString() {
    return '$id + $name';
  }
}
