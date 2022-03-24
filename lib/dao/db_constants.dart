class DBConstants {
  //feed_the_cat db
  static const String feedTheCatDB = 'feed_the_cat.db';

  //user_info_table
  static const String recordTable = 'record_table';
  static const String recordIdColumn = 'record_id';
  static const String recordUserNameColumn = 'record_user_name';
  static const String recordDateColumn = 'record_date';
  static const String recordScoreColumn = 'record_score';

  //progress_table
  static const String progressTable = 'progress_table';
  static const String progressIdColumn = 'progress_id';
  static const String progressUserNameColumn = 'progress_user_name';
  static const String progressNameColumn = 'progress_name';

  //SQL
  //create scripts
  static const String createRecordTable = '''
      create table ${DBConstants.recordTable}(
      ${DBConstants.recordIdColumn} integer primary key autoincrement,
      ${DBConstants.recordUserNameColumn} text not null,
      ${DBConstants.recordDateColumn} datetime,
      ${DBConstants.recordScoreColumn} integer)
      ''';

  static const String createProgressTable = '''
      create table ${DBConstants.progressTable}(
      ${DBConstants.progressIdColumn} integer primary key autoincrement,
      ${DBConstants.progressUserNameColumn} text not null,
      ${DBConstants.progressNameColumn} text not null)
    ''';
}
