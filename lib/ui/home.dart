// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:guess_citizen_flutter/model/movie.dart';

import 'package:guess_citizen_flutter/model/question.dart';

class MovieView extends StatelessWidget {
  final List<Movie> movielist = Movie.getMoveis();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.redAccent,
      ),
      // backgroundColor: Colors.red.shade100,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.deepOrange, Colors.orangeAccent])),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        // child: Image.asset("image/khmer.png",width: 80,height: 80,),
                        child: Container(
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Cambodia",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            CustomListTile(Icons.person, "Profile", () => {}),
            CustomListTile(Icons.notifications, "Notifications", () => {}),
            CustomListTile(Icons.settings, "Settings", () => {}),
            CustomListTile(Icons.lock, "LogOut", () => {}),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey.shade400,
      body: ListView.builder(
          itemCount: movielist.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: <Widget>[
                movieCard(movielist[index], context),
                Positioned(
                    top: 10.0, child: movieImage(movielist[index].images[0])),
              ],
            );
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 63),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          movie.titile,
                          style: TextStyle(fontSize: 17.0, color: Colors.white),
                        ),
                      ),
                      Text(
                        " Rating: ${movie.imdbrating} / 10",
                        style: mainTextStyle(),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Released : ${movie.release}",
                        style: mainTextStyle(),
                      ),
                      Text(movie.runtime, style: mainTextStyle()),
                      Text(movie.rated, style: mainTextStyle()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MoviesViewDetail(
                    movieName: movie.titile,
                    movie: movie,
                  )),
        );
      },
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(fontSize: 15.0, color: Colors.grey);
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(imageUrl ??
                  'https://i.pinimg.com/originals/e6/d6/99/e6d6998ff16e945a313ff175c233de6d.png'),
              fit: BoxFit.cover)),
    );
  }
}

//New Route (Screen Detail Movies)
class MoviesViewDetail extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MoviesViewDetail({Key key, this.movieName, this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${this.movieName}"),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      // body: Center(
      //   child: Container(
      //     child: RaisedButton(
      //       child: Text("Go Back ${this.movie.director}"),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // ),
      body: ListView(
        children: <Widget>[
          MovieDetailInfo(
            info: movie.images[0],
          ),
          MovieDetailHeaderWithPoster(
            movie: movie,
          ),
          MovieDatailCast(
            movie: movie,
          ),
          HorizotalLine(),
          MovieDatialExtraPosters(
            posters: movie.images,
          )
        ],
      ),
    );
  }
}

class HorizotalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDatialExtraPosters extends StatelessWidget {
  final List<String> posters;

  const MovieDatialExtraPosters({Key key, this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "More Movie Posters".toUpperCase(),
            style: TextStyle(fontSize: 14, color: Colors.black26),
          ),
        ),
        Container(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(
              width: 8.0,
            ),
            itemCount: posters.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 170,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(posters[index]),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;
  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        height: 50,
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_right,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieDetailInfo extends StatelessWidget {
  final String info;

  const MovieDetailInfo({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(info), fit: BoxFit.cover)),
            ),
            Icon(
              Icons.play_circle_outline,
              size: 100,
              color: Colors.white,
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: 80,
        )
      ],
    );
  }
}

class MovieDetailHeaderWithPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailHeaderWithPoster({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[0].toString()),
          SizedBox(
            width: 16,
          ),
          Expanded(child: MovieDetailHeader(movie: movie))
        ],
      ),
    );
  }
}

class MovieDetailHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailHeader({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year}.${movie.genre}".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.cyanAccent,
          ),
        ),
        Text(
          movie.titile,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
        ),
        Text.rich(
          TextSpan(
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              children: <TextSpan>[
                TextSpan(text: movie.plot),
                TextSpan(
                    text: "More.....", style: TextStyle(color: Colors.blue))
              ]),
        )
      ],
    );
  }
}

class MovieDatailCast extends StatelessWidget {
  final Movie movie;

  const MovieDatailCast({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Directors", value: movie.director),
          MovieField(field: "Awards ", value: movie.awards),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key key, this.field, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field : ",
          style: TextStyle(
              color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

//Quiz App Only

class True extends StatefulWidget {
  @override
  _TrueState createState() => _TrueState();
}

class _TrueState extends State<True> {
  int _currentquestionIndex = 0;
  List questions = [
    // "The U.S declaration of Independece was adopted in 1776",
    // "The Cambodia declaration of Independece was adopted in 1979",
    // "The Flower declaration of Cambodia is Cocumber",
    Question.name(
        "The U.S declaration of Independece was adopted in 1776", true),
    Question.name("The Cambodia neckname Khmer", true),
    Question.name(
        "The Cambodia declaration of Independence was adopted in 1979", true),
    Question.name(
        "Hello World the Most Sentence that programmer using for Beginner",
        true),
    Question.name("Bye World is Hello world", false),
    Question.name(
        "The Cambodia declaration of Independence was adopted in 1999", false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("True Citizen"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Builder(
        builder: (BuildContext context) => Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 120,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          questions[_currentquestionIndex].questionText,
                          style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () => _checkAnswer(false, context),
                      color: Colors.blue,
                      child: Text(
                        "FALSE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () => _checkAnswer(true, context),
                      color: Colors.blue,
                      child: Text(
                        "TRUE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () => _nextquestion(),
                      color: Colors.blue,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _checkAnswer(bool userchoice, BuildContext context) {
    if (userchoice == questions[_currentquestionIndex].isCorrect) {
      final snackbar = SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500),
          content: Text("Correct"));
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(snackbar);
      _updatequestion();
    } else {
      final snackbar = SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 500),
          content: Text("Incorrect"));
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(snackbar);
      _updatequestion();
    }
  }

  _updatequestion() {
    setState(() {
      _currentquestionIndex = (_currentquestionIndex + 1) % questions.length;
    });
  }

  _nextquestion() {
    _updatequestion();
  }
}
