import 'package:flutter/material.dart';

import '../../dao/db_helper.dart';
import '../../models/progress.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progresses'),
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
                    child: Text("No Progresses",
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
          'Name of Progress',
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    ];
  }

  Future<List<DataRow>> _createRows() async {
    List<Progress> results = await DBHelper.instance.getProgressList();
    return results
        .map((progress) => DataRow(cells: [
              DataCell(Text(progress.userName.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ))),
              DataCell(Text(progress.name.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ))),
            ]))
        .toList();
  }
}
