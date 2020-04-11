
import 'package:app/model/repositories.dart';
import 'package:app/model/models.dart';

class LocalCategoryRepository implements CategoryRepository {
  final _innerList = [
    Category(339,
        "Colombe, Pandolci e Panettoni",
        "ricette-per-colombe-pandolci-panettoni",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2017/09/colombe-pandolci.jpeg"),
    Category(316,
        "Dolci",
        "ricette-dolci",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2017/09/dolci.jpeg"),
    Category(311,
        "Focacce",
        "ricette-focacce",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2017/09/focacce.jpeg"),
    Category(354,
        "Lievito Naturale",
        "ricette-lievito-naturale",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2017/09/lievito-naturale.jpeg"),
    Category(355,
        "Pane Lievito Naturale",
        "ricette-pane-lievito-naturale",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2010/04/dsc00852-1024x768.jpg"),
    Category(328,
        "Pane Integrale",
        "ricette-pane-integrale",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2014/04/Ricetta-Pane-Integrale-Miele-Cacao-e-Caffe’.jpg"),
    Category(329,
        "Pane Semplice",
        "video-ricette-pane-semplice",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2016/05/Pane-Artigianale-Fatto-in-Casa-in-5-Minuti.jpg"),
    Category(580,
        "Pane senza Glutine",
        "ricette-pane-senza-glutine",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2016/11/pane-teff-1-1024x768.jpg"),
    Category(614,
        "Pizza",
        "ricette-pizza",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2017/09/ricette-pizza.jpeg"),
    Category(495,
        "Forno a Legna",
        "ricette-forno-a-legna",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2017/09/ricette-forno-legna.jpeg"),
    Category(571,
        "Torte Salate",
        "ricette-torte-salate",
        "",
        "https://vivalafocaccia.com/wp-content/uploads/2017/09/torte-salate.jpeg")
  ];

  @override
  Future<Category> getFromId(int id) {
    return Future.value(_innerList.firstWhere((element) => element.id == id));
  }

  @override
  List<Future<Category>> getMany({offset:0, count:11,
    order:CategoryOrder.importance}) {
    return _innerList.sublist(offset, count).map((e) => Future.value(e)).toList();
  }

}