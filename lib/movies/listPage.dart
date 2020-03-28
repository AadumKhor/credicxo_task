import 'package:credicxo_task/bloc/bloc.dart';
import 'package:credicxo_task/config/config.dart';
import 'package:flutter/material.dart';

import 'movie_container.dart';

class ListPage extends StatefulWidget {
  final MoviesLoaded state;
  final MoviesBloc bloc;

  ListPage({@required this.state, @required this.bloc})
      : assert(state != null, bloc != null);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  MoviesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xff1515ad),
        elevation: 4.0,
        title: Text(
          'Popular Movies',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                _bloc.add(SearchButtonClicked());
              })
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 4.0),
        child: ListView.builder(
            itemCount: widget.state.movies.length,
            itemBuilder: (context, index) {
              if (widget.state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final movie = widget.state.movies[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: GestureDetector(
                  onTap: () {
                    _bloc.add(FetchMovieDetails(movieId: movie.movieId));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 4.0,
                    child: Container(
                      margin: EdgeInsets.all(2.0),
                      width: double.maxFinite,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Hero(
                                tag: 'photo',
                                child: Container(
                                  height: 200.0,
                                  width: 200.0,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(imageUrl +
                                              movie.imgPath
                                                  .replaceAll("\\", "")))),
                                ),
                              )),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child: RichText(
                                    softWrap: true,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: '${movie.name}\n\n',
                                          style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 1.2,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: '⭐ ${movie.rating.toString()}\n',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                          text: movie.language.toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold)),
                                    ])),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
