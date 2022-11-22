import 'package:flutter/material.dart';

import 'data_object.dart';

Future<void> dialogBuilder(BuildContext context, Function callback) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Basic dialog title'),
        content: const Text('A dialog'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
              callback(
                DataObject(item: 'cola', measurementUnit: 'dcl', price: 50),
              );
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              Navigator.of(context).pop();
              callback(
                DataObject(item: 'cola', measurementUnit: 'dcl', price: 50),
              );
            },
          ),
        ],
      );
    },
  );
}