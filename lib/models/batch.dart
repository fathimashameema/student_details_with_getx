import 'package:animated_custom_dropdown/custom_dropdown.dart';

List<String> batches = [
 'Batch',
 'BCR60',
 'BCR61',
 'BCR62',
 'BCR63',
 'BCR64',
];

class Batch with CustomDropdownListFilter {
  final String name;

  Batch(
    this.name,
  );

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}
