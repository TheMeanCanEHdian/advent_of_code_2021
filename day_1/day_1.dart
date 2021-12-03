// https://adventofcode.com/2021/day/1

import 'dart:io';

// Calculates how many times the current value is larger than the last
int numTimesLarger(List<int> values) {
  int numTimesLarger = 0;

  for (var i = 0; i < values.length; i++) {
    if (i > 0 && values[i] > values[i - 1]) {
      numTimesLarger += 1;
    }
  }

  return numTimesLarger;
}

main() async {
  final File file = File(Directory.current.path + '/day_1/input.txt');
  List values = await file.readAsLines();
  values = values.map((value) => int.parse(value)).toList();

  //! PART 1
  print(numTimesLarger(values as List<int>));

  //! PART 2
  List<int> window_values = [];

  for (var i = 0; i < values.length - 2; i++) {
    window_values.add(
      values[i] + values[i + 1] + values[i + 2],
    );
  }

  print(numTimesLarger(window_values));
}
