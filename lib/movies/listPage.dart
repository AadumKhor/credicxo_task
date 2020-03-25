import 'package:credicxo_task/bloc/bloc.dart';
import 'package:credicxo_task/config/config.dart';
import 'package:flutter/material.dart';

import 'movie_container.dart';

class ListPage extends StatefulWidget {
  final MoviesLoaded state;
  final MoviesBloc bloc;
  final ValueChanged<PageDirection> onPagechanged;

  ListPage({@required this.state, @required this.bloc, this.onPagechanged})
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
        backgroundColor: Colors.blue,
        title: Text('Popular Movies'),
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
                    widget.onPagechanged(PageDirection.next);
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
                                          movie.imgPath.replaceAll("\\", "")))),
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
      ),
    );
  }
}
