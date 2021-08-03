import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("transferências"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text("100.0"),
              subtitle: Text("1000"),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text("200.0"),
              subtitle: Text("1000"),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    ),
  ));
}
