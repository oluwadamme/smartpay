import 'package:hive/hive.dart';

class HiveService {
  Future<bool> isExists({String? boxName}) async {
    final openBox = await Hive.openBox(boxName!);
    int length = openBox.length;

    return length != 0;
  }

  addBoxes<T>(String boxName, List<T> items) async {
    //print("adding boxes");
    final openBox = await Hive.openBox(boxName);
    var keys = [];
    if (openBox.values.isNotEmpty) {
      for (var k = 0; k < openBox.values.length; k++) {
        keys.add(openBox.keyAt(k));
        // await openBox.deleteAt(k);
      }

      if (keys.isNotEmpty) await openBox.deleteAll(keys);
    }

    for (var item in items) {
      openBox.add(item);
    }
  }

  addBox<T>(String boxName, T item) async {
    print("adding box");
    final openBox = await Hive.openBox(boxName);

    openBox.put(boxName, item);
  }

  addBoxToArray<T>(String boxName, T item) async {
    // print("adding box");
    // print(item);
    final openBox = await Hive.openBox(boxName);

    openBox.add(item);
  }

  updateBox<T>(String boxName, T item) async {
    final openBox = await Hive.openBox(boxName);
    var index = openBox.length - 1;

    openBox.putAt(index, item);
  }

  getBox<T>(String boxName) async {
    final openBox = await Hive.openBox(boxName);

    return openBox.get(boxName);
  }

  Future<List<T>> getBoxes<T>(String boxName) async {
    List<T> boxList = [];

    final openBox = await Hive.openBox(boxName);

    int length = openBox.length;

    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }

    return boxList;
  }

  closeBox(String boxName) async {
    final openBox = await Hive.openBox(boxName);
    // openBox.clear();
    openBox.close();
  }

  close() => Hive.close();

  clear(String boxName) async {
    final openBox = await Hive.openBox(boxName);
    openBox.clear();
  }

  deleteFromDisk(String boxName) async {
    final openBox = await Hive.openBox(boxName);
    // openBox.delete(boxName);
    await openBox.clear();
    await openBox.deleteFromDisk();
  }
}
