// ignore_for_file: void_checks

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/cache_helper.dart';
import 'package:news_app/controller/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  // Variable///////////////////////////

  bool isDark = false;
  late Database database;
  int selectedColor = 0;
  String selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int selectedRemind = 5;
  List<int> reminList = [5, 10, 15, 20, 25];
  List<Map> tasks = [];

  /// Change Mode To Dark or Light ////////////////
  ///
  ///
  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeState());
      });
    }
  }

  void changeColor(index) {
    selectedColor = index;
    emit(ChangeColorState());
  }

  void changeRemind(index) {
    selectedRemind = index;
    emit(SelectRemaindState());
  }

  void selectRepeat(value) {
    selectedRepeat = value.toString();
    emit(SelectRepeateState());
  }

// Database Controller /////////////////////////////////////////////////////////

  void createDatabase() {
    openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (database, version) async {
        print('Database Created');

        await database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT, date TEXT, stime TEXT, etime TEXT, remind INTEGER, repate TEXT, color INTEGER, isComplete INTEGER)')
            .then((value) {
          print('Table Created');
        }).catchError((erorr) {
          print('Erorr table ${erorr.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('Database Opened');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  Future insertDatabase({
    required String title,
    required String note,
    required String date,
    required String stime,
    required String etime,
    required String remind,
    required String repate,
    required dynamic color,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title, note, date, stime, etime, remind, repate, color, isComplete) VALUES("$title", "$note", "$date", "$stime", "$etime", "$remind", "$repate", "$color", "0")')
          .then((value) {
        print('$value Inserted Successfully');
        emit(InsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((erorr) {
        print('Erorr Inserted ${erorr.toString()}');
      });
      //return null!;
    });
  }

  void getDataFromDatabase(database) {
    database.rawQuery('SELECT * FROM tasks').then((value) {
      tasks = value;
      //print(tasks);

      value.forEach((element) {
        print(element['isComplete']);
      });
      emit(GetDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    return await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(DeleteDatabaseState());
    });
  }

  void updateData({
    required int id,
  }) async {
    database.rawUpdate(
        'UPDATE tasks SET isComplete =? WHERE id = ?', [1, id]).then((value) {
      getDataFromDatabase(database);

      emit(UpdateDatabaseState());
    });
  }
}
