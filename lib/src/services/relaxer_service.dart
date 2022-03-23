
import '../../boxes.dart';
import '../models/relaxer.dart';

class RelaxerService {

  final boxRelaxer = Boxes.getRelaxers();

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

  void delete() {
    for (Relaxer el in boxRelaxer.values) {
      if(el.isActive) {
        el.delete();
      }
    }
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

  List<Relaxer> getRelaxers() {
    return boxRelaxer.values.toList();
  }

}