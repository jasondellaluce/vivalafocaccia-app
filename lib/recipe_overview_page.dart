
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecipeOverviewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            child: Column(
              children: <Widget>[
                _HeaderImageWidget(),
                _HeaderDetailsWidget(),
                _IngredientDetailsWidget()
              ],
            )
        ),
      )
    );
  }
  
}

class _HeaderImageWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HeaderImageState();

}

class _HeaderImageState extends State<_HeaderImageWidget> {
  bool _videoPlayEnabled = false;
  final imageHeightRatio = 0.50;
  YoutubePlayerController _videoController;

  @override
  void initState() {
    _videoController = YoutubePlayerController(
      initialVideoId: 'F8kEpPfna6w',
      flags: YoutubePlayerFlags(
        loop: true,
        autoPlay: true,
        mute: false,
        enableCaption: false
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * imageHeightRatio,
      width : double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage("https://vivalafocaccia.com/wp-content/uploads/2020/04/Lievito-di-Birra-1-e1586059790343.jpg")
        )
      ),
      child: Stack(
        children: <Widget>[
          _videoPlayEnabled
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * imageHeightRatio,
                    child: YoutubePlayer(
                      controller: _videoController,
                      showVideoProgressIndicator: false,
                      thumbnailUrl: "https://vivalafocaccia.com/wp-content/uploads/2020/04/Lievito-di-Birra-1-e1586059790343.jpg",
                    ),
                  )
                )
              : Center(
                  child: GestureDetector(
                    onTap: _onPlayButtonPressed,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 20.0, // has the effect of softening the shadow
                              spreadRadius: 5.0, // has the effect of extending the shadow
                              offset: Offset(0.0, 0.0),
                            )
                          ]
                      ),
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.play_arrow, color: Colors.white, size: MediaQuery.of(context).size.width * 0.12),
                    ),
                  ),
                ),
          Positioned(
            left: 15,
            top: 40,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(80),
                      blurRadius: 20.0, // has the effect of softening the shadow
                      spreadRadius: 1.0, // has the effect of extending the shadow
                      offset: Offset(5.0, 8.0),
                    )
                  ]
              ),
              child: Material(
                borderRadius: BorderRadius.circular(100),
                child: GestureDetector(
                  onTap: _onBackButtonPressed,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            )
          ),
          Positioned(
            right: 0,
            top: 40,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.30,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(80),
                    blurRadius: 20.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: Offset(5.0, 8.0),
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: _onLikeButtonPressed,
                      child: Container(
                        child: Icon(CupertinoIcons.heart, color: Colors.red),
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: _onShareButtonPressed,
                      child: Container(
                        child: Icon(CupertinoIcons.share),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:  Radius.circular(50), topRight:  Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(80),
                      blurRadius: 20.0, // has the effect of softening the shadow
                      spreadRadius: 1.0, // has the effect of extending the shadow
                      offset: Offset(0.0, -20.0),
                    )
                  ]
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Center(
                child: Text(
                  "Ricetta Lievito di Birra Fatto in Casa",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  void _onBackButtonPressed() {
    print("back pressed");
  }

  void _onLikeButtonPressed() {
    print("like pressed");
  }

  void _onShareButtonPressed() {
    print("share pressed");
  }

  void _onPlayButtonPressed() {
    setState(() {
      _videoPlayEnabled = true;
    });
  }
}

class _HeaderDetailsWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.white,
    );
  }
}

class _IngredientDetailsWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.green,
    );
  }
}


