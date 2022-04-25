import 'package:hive/hive.dart';
import '../../models/relaxer.dart';
import 'db_service.dart';

class RelaxerDBService extends DBService<Relaxer> {

  final boxRelaxer = Hive.box<Relaxer>('relaxer');

  void add(Relaxer relaxer) {
    for (Relaxer el in boxRelaxer.values) {
      if (el == relaxer) {
        el.isActive = true;
        el.save();
        return;
      }
    }
    relaxer.isActive = true;
    boxRelaxer.add(relaxer);
  }

  void delete(Relaxer relaxer) {
    relaxer.delete();
  }

  @override
  void addAll(Iterable<Relaxer> relaxers) {
    boxRelaxer.addAll(relaxers);
  }

  @override
  void deleteAll() {
    boxRelaxer.deleteAll(boxRelaxer.keys);
  }

  @override
  List<Relaxer> getAll() {
    return boxRelaxer.values.toList();
  }

  Relaxer getActive() {
    for (Relaxer el in boxRelaxer.values) {
      if(el.isActive) {
        return el;
      }
    }
    return Relaxer(
        email: 'privet@gmail.com',
        name: 'Name',
        surname: 'Surname',
        sex: true,
        isActive: true,
        sanatorium: ""
    );
  }

  bool hasActive() {
    for (Relaxer el in boxRelaxer.values) {
      if(el.isActive) {
        return true;
      }
    }
    return false;
  }

  void makeInActive() {
    for (Relaxer el in boxRelaxer.values) {
      if (el.isActive) {
        el.isActive = false;
        el.save();
      }
    }
  }

  void makeActive(Relaxer relaxer) {
    for (Relaxer el in boxRelaxer.values) {
      if (el == relaxer) {
        el.isActive = true;
        el.save();
      }
    }
  }
}