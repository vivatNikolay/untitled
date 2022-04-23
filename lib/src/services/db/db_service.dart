
abstract class DBService<T> {

  void add(T t);

  void addAll(Iterable<T> iterable);

  void delete(T t);

  void deleteAll();

  List<T> getAll();
}