import 'package:credicxo_task/bloc/bloc.dart';
import 'package:credicxo_task/config/config.dart';
import 'package:flutter/material.dart';

import 'movie_container.dart';

class SearchPage extends StatefulWidget {
  final Search state;
  final MoviesBloc bloc;
  final ValueChanged<PageDirection> onPageChanged;

  SearchPage({this.onPageChanged, @required this.bloc, @required this.state})
      : assert(bloc != null, state != null);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8142f5),
          elevation: 4.0,
          title: Text('Movie Details'),
          leading: IconButton(
              onPressed: () {
                widget.onPageChanged(PageDirection.back);
                widget.bloc.add(FetchMovieList());
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(vertical: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _searchBar(),
              SizedBox(height: 20.0),
              widget.state.isSearching ? _searchInit() : _searchDone()
            ],
          ),
        ));
  }

  Widget _searchDone() {
    if (widget.state.searchResults.length != 0) {
      return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.state.searchResults.length,
            itemBuilder: (context, index) {
              final movie = widget.state.searchResults[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: GestureDetector(
                  onTap: () {
                    widget.bloc.add(FetchMovieDetails(movieId: movie.movieId));
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: 150.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.green)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: NetworkImage(imageUrl +
                                          movie.imgPath
                                              ?.replaceAll("\\", "")))),
                            )),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: '${movie.name}\n',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: movie.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.normal))
                              ])),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _searchInit() {
    return Center(child: Text('Please enter a keyword to search..'));
  }

  Widget _searchBar() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 4.0,
      color: Colors.transparent,
      child: Container(
        width: double.maxFinite,
        height: 80.0,
        decoration: new BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: TextField(
                autofocus: false,
                onChanged: (String value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration.collapsed(
                    hintText: 'Search for movies..',
                    hintStyle: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300)),
              ),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    print(_searchQuery);
                    widget.bloc.add(SearchForMovie(name: _searchQuery.trim()));
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
