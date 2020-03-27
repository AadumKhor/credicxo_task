import 'package:credicxo_task/bloc/bloc.dart';
import 'package:credicxo_task/config/constants.dart';
import 'package:flutter/material.dart';

import 'movie_container.dart';

class DetailsPage extends StatefulWidget {
  final MovieDetailsLoaded state;
  final MoviesBloc bloc;

  DetailsPage({Key key, @required this.bloc, @required this.state})
      : assert(state != null, bloc != null),
        super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _headingStyle = new TextStyle();
  final _detailsStyle = new TextStyle();

  // final _cion = IconButton(
  //     onPressed: () {
  //       widget.bloc.add(FetchMovieList());
  //     },
  //     icon: Icon(Icons.arrow_back));

  @override
  Widget build(BuildContext context) {
    final details = widget.state.details;
    return Scaffold(
      body: widget.state.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: 'photo',
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(imageUrl + details.imagePath),
                        ),
                      ),
                      Positioned(
                        top: 30.0,
                        left: 20.0,
                        child: IconButton(
                            onPressed: () {
                              widget.bloc.add(FetchMovieList());
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30.0,
                            )),
                      ),
                      widget.state.details.isAdult
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'A',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.state.details.name,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _titleAndDetails(
                      'Release Date', widget.state.details.releaseDate),
                  _titleAndDetails('Language', widget.state.details.language),
                ],
              ),
            ),
    );
  }

  Widget _titleAndDetails(String title, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '$title\n',
          ),
          TextSpan(
            text: details,
          )
        ]),
      ),
    );
  }
}
