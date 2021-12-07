// https://adventofcode.com/2021/day/7

import 'dart:io';

// Basic fuel calculation using the middle number from the list of positions.
// Assumes every move by a crab costs 1 fuel.
void basicFuelCalculation(List<int> crabPositions) {
  int middleNumber = crabPositions[crabPositions.length ~/ 2];
  int fuel = 0;
  crabPositions.forEach((position) {
    if (position > middleNumber) {
      fuel += position - middleNumber;
    } else {
      fuel += middleNumber - position;
    }
  });

  print(fuel);
}

// Calculates fuel costs based on the mean value. Uses the mean drift to
// determine start and end values to calculate between. Assumes every move by a
// crab costs  1 more fuel than their last move.
void meanFuelCalculation(List<int> crabPositions, {int meanDrift = 1}) {
  int mean =
      (crabPositions.reduce((a, b) => a + b) / crabPositions.length).round();

  int fuel = 99999999999999;

  for (int i = mean - meanDrift; i < mean + meanDrift; i++) {
    int fuelCalculation = 0;

    crabPositions.forEach((position) {
      int numOfMoves = 0;
      // Calcualate how many movies the crab will need to make.
      if (position > i) {
        numOfMoves = position - i;
      } else if (position < i) {
        numOfMoves = i - position;
      }

      // Find the sum of all values between 1 and the number of moves needed.
      fuelCalculation += ((numOfMoves * (numOfMoves + 1)) / 2).round();
    });

    if (fuelCalculation < fuel) {
      fuel = fuelCalculation;
    }
  }

  print(fuel);
}

void main() async {
  final File file = File(Directory.current.path + '/day_7/input.txt');
  List<int> values = await file.readAsLines().then((lines) {
    List<String> stringList = lines[0].split(',');
    List<int> ints = [];
    for (String value in stringList) {
      ints.add(int.parse(value));
    }
    return ints;
  });
  values.sort((a, b) => a.compareTo(b));

  //! PART 1
  basicFuelCalculation(values);

  //! PART 2
  meanFuelCalculation(values);
}
