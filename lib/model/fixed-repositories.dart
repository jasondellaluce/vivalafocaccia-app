
import 'package:app/model/repositories.dart';
import 'package:app/model/types.dart';

class FixedCategoryRepository implements CategoryRepository {
  final _innerList = [
    Category(339, "Ricette per Colombe, Pandolci e Panettoni",
        "ricette-per-colombe-pandolci-panettoni"),
    Category(316, "Ricette Dolci", "ricette-dolci"),
    Category(311, "Ricette Focacce", "ricette-focacce"),
    Category(354, "Ricette Lievito Naturale", "ricette-lievito-naturale"),
    Category(355, "Ricette Pane Lievito Naturale",
        "ricette-pane-lievito-naturale"),
    Category(328, "Ricette Pane Integrale", "ricette-pane-integrale"),
    Category(329, "Video Ricette Pane Semplice", "video-ricette-pane-semplice"),
    Category(580, "Ricette pane senza glutine", "ricette-pane-senza-glutine"),
    Category(614, "Ricette Pizza", "ricette-pizza"),
    Category(495, "Ricette Forno a Legna", "ricette-forno-a-legna"),
    Category(571, "Ricette Sorte Salate", "ricette-torte-salate")
  ];

  @override
  Future<Category> getFromId(int id) {
    return Future.value(_innerList.firstWhere((element) => element.id == id));
  }

  @override
  Future<List<Category>> getMany({offset:0, count:11,
      order:CategoryOrder.importance}) {
    return Future.value(_innerList.sublist(offset, count));
  }

}