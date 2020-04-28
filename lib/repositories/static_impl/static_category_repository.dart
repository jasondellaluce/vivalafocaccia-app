
import 'package:app/models/models.dart';

import '../category_repository.dart';
import '../common.dart';

class StaticCategoryRepository implements CategoryRepository {

  final _innerList = [
    Category(
        id: 339,
        parentId : 0,
        name: "Colombe, Pandolci e Panettoni",
        code: "ricette-per-colombe-pandolci-panettoni",
        pageUrl : "",
        featuredImageUrl :"https://vivalafocaccia.com/wp-content/uploads/2017/09/colombe-pandolci.jpeg"),
    Category(
        id : 316,
        parentId : 0,
        name : "Dolci",
        code : "ricette-dolci",
        pageUrl : "",
        featuredImageUrl : "https://vivalafocaccia.com/wp-content/uploads/2017/09/dolci.jpeg"),
    Category(
        id : 311,
        parentId : 0,
        name : "Focacce",
        code : "ricette-focacce",
        pageUrl : "",
        featuredImageUrl : "https://vivalafocaccia.com/wp-content/uploads/2017/09/focacce.jpeg"),
    Category(
        id : 354,
        name : "Lievito Naturale",
        code : "ricette-lievito-naturale",
        pageUrl : "",
        featuredImageUrl : "https://vivalafocaccia.com/wp-content/uploads/2017/09/lievito-naturale.jpeg"),
    Category(
        id : 355,
        parentId : 0,
        name : "Pane Lievito Naturale",
        code : "ricette-pane-lievito-naturale",
        pageUrl : "",
        featuredImageUrl : "https://vivalafocaccia.com/wp-content/uploads/2010/04/dsc00852-1024x768.jpg"),
    Category(
        id : 328,
        parentId : 0,
        name : "Pane Integrale",
        code : "ricette-pane-integrale",
        pageUrl : "",
        featuredImageUrl : "https://vivalafocaccia.com/wp-content/uploads/2014/04/Ricetta-Pane-Integrale-Miele-Cacao-e-Caffe’.jpg"),
    Category(
        id : 329,
        parentId : 0,
        name : "Pane Semplice",
        code : "video-ricette-pane-semplice",
        pageUrl : "",
        featuredImageUrl : "https://vivalafocaccia.com/wp-content/uploads/2016/05/Pane-Artigianale-Fatto-in-Casa-in-5-Minuti.jpg"),
    Category(
        id : 580,
        parentId : 0,
        name : "Pane senza Glutine",
        code : "ricette-pane-senza-glutine",
        pageUrl : "",
        featuredImageUrl : "https://vivalafocaccia.com/wp-content/uploads/2016/11/pane-teff-1-1024x768.jpg"),
    Category(
        id : 614,
        parentId : 0,
        name : "Pizza",
        code : "ricette-pizza",
        pageUrl : "",
        featuredImageUrl : "https://vivalafocaccia.com/wp-content/uploads/2017/09/ricette-pizza.jpeg"),
    Category(
        id : 495,
        parentId : 0,
        name : "Forno a Legna",
        code :"ricette-forno-a-legna",
        pageUrl : "",
        featuredImageUrl : "https://vivalafocaccia.com/wp-content/uploads/2017/09/ricette-forno-legna.jpeg"),
    Category(
        id : 571,
        parentId : 0,
        name : "Torte Salate",
        code : "ricette-torte-salate",
        pageUrl : "",
        featuredImageUrl : "https://vivalafocaccia.com/wp-content/uploads/2017/09/torte-salate.jpeg")
  ];

  @override
  Future<Category> read(CategorySingleReadRequest request) {
    if(request.id != null && request.code != null)
      throw new RepositoryInvalidRequestError("Can't read both by id and code");

    if(request.id != null) {
      var value = _innerList.firstWhere((e) => e.id == request.id,
          orElse: () => null);
      if(value != null)
        return Future.value(value);
      return Future.error(RepositorySingleReadError("no such element"));
    }

    if(request.code != null) {
      var value = _innerList.firstWhere((e) => e.code == request.code,
          orElse: () => null);
      if(value != null)
        return Future.value(value);
      return Future.error(RepositorySingleReadError("no such element"));
    }

    throw new RepositoryInvalidRequestError("Should specify id or code");
  }

  @override
  Future<List<Category>> readMany(CategoryMultiReadRequest request) {
    var skip = request.readOffset == null ? 0 : request.readOffset;
    var limit = request.readCount == null
        ? _innerList.length : request.readCount;
    return Future.value(_innerList.skip(skip).take(limit).toList());
  }

}