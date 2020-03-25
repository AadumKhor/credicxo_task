import 'package:credicxo_task/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  final MovieDetailsLoaded state;

  DetailsPage({Key key, @required this.state})
      : assert(state != null),
        super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.state.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text(widget.state.details,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
    );
  }
}
