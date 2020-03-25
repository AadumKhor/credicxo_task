import 'package:credicxo_task/bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'movie_container.dart';

class DetailsPage extends StatefulWidget {
  final MoviesLoaded state;
  final ValueChanged<PageDirection> onPageChanged;
  final MoviesBloc bloc;

  DetailsPage(
      {Key key, @required this.bloc, @required this.state, this.onPageChanged})
      : assert(state != null, bloc != null),
        super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onPageChanged(PageDirection.back);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Movie Details'),
          leading: IconButton(
              onPressed: () {
                widget.onPageChanged(PageDirection.back);
                widget.bloc.add(FetchMovieList());
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: widget.state.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Text(widget.state.details,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
      ),
    );
  }
}
