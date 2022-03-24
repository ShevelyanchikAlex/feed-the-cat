import '../dao/db_constants.dart';
import '../dao/db_contract.dart';

class Record implements DBContract {
  final int? id;
  final String userName;
  final String dateTime;
  final int score;

  Record({
    this.id,
    required this.userName,
    required this.dateTime,
    required this.score,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      DBConstants.recordIdColumn: id,
      DBConstants.recordUserNameColumn: userName,
      DBConstants.recordDateColumn: dateTime,
      DBConstants.recordScoreColumn: score,
    };
  }

  factory Record.fromMap(Map<String, dynamic> map) {
    return Record(
      id: map[DBConstants.recordIdColumn],
      userName: map[DBConstants.recordUserNameColumn],
      dateTime: map[DBConstants.recordDateColumn],
      score: map[DBConstants.recordScoreColumn],
    );
  }
}
