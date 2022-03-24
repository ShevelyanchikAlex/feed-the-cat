
import 'package:flutter/material.dart';

import '../../dao/db_helper.dart';
import '../../models/record.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  final String title = 'Results';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<DataTable>(
          future: _createTable(),
          builder: (BuildContext context, AsyncSnapshot<DataTable> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: Text("Loading...",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )));
            }
            return snapshot.data!.rows.isEmpty
                ? const Center(
                    child: Text("No Records",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )))
                : ListView(
                    children: [snapshot.requireData],
                  );
          }),
    );
  }

  Future<DataTable> _createTable() async {
    return DataTable(
      columns: _createColumns(),
      rows: await _createRows(),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text(
          'UserName',
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Score',
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
      const DataColumn(
        label: Text(
          'Date',
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      )
    ];
  }

  Future<List<DataRow>> _createRows() async {
    List<Record> results = await DBHelper.instance.getRecordList();
    return results
        .map((userInfo) => DataRow(cells: [
              DataCell(Text(userInfo.userName.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ))),
              DataCell(Text(userInfo.score.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ))),
              DataCell(Text(userInfo.dateTime.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ))),
            ]))
        .toList();
  }
}
