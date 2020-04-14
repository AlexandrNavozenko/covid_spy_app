import 'package:flutter/material.dart';

class ObserverFuture<T> extends StatelessWidget {
  @required
  final Future<T> future;

  @required
  final Function onError;
  final Function onSuccess;
  final Function onWaiting;

  const ObserverFuture({this.onError, this.onSuccess, this.future, this.onWaiting});

  Function get _defaultOnError => (context, error) => Text(error);

  Function get _defaultOnWaiting =>
          (context) => Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return (onError != null)
              ? onError(context, snapshot.error.toString())
              : _defaultOnError(context, snapshot.error.toString());
        }

        if (snapshot.hasData) {
          T data = snapshot.data;
          return onSuccess(context, data);
        } else {
          return (onWaiting != null)
              ? onWaiting(context)
              : _defaultOnWaiting(context);
        }
      },
    );
  }
}
