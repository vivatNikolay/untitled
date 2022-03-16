
import '../../boxes.dart';
import '../models/relaxer.dart';

class RelaxerService {

  final boxRelaxer = Boxes.getRelaxer();

  void add(Relaxer relaxer) {
    relaxer.isActive = true;
    if (boxRelaxer.values.any((el) => el.email == relaxer.email)) {
      return;
    }
    boxRelaxer.add(relaxer);
  }

  void delete() {
    boxRelaxer.clear();
  }

  Relaxer getActive() {
    for (Relaxer el in boxRelaxer.values) {
      if(el.isActive) {
        return el;
      }
    }
    return Relaxer(email: 'privet@gmail.com', name: 'Name', surname: 'Surname', sex: true, isActive: true);
  }

  void makeInActive() {
    for (Relaxer el in boxRelaxer.values) {
      if (el.isActive) {
        el.isActive = false;
        el.save();
      }
    }
  }

}