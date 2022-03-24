import 'package:feed_the_cat_app/dao/db_constants.dart';

import '../dao/db_contract.dart';

class Progress implements DBContract {
  final int? id;
  final String userName;
  final String name;

  Progress({
    this.id,
    required this.userName,
    required this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      DBConstants.progressIdColumn: id,
      DBConstants.progressUserNameColumn: userName,
      DBConstants.progressNameColumn: name,
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      id: map[DBConstants.progressIdColumn],
      userName: map[DBConstants.progressUserNameColumn],
      name: map[DBConstants.progressNameColumn],
    );
  }
}
