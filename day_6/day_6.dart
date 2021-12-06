// https://adventofcode.com/2021/day/5

// Removing null safety as its being a huge pain when it comes to referencing
// the fish generations in generationTracker().
// @dart=2.9
import 'dart:io';

// Original function used with PART 1. This is a simple brute force approach
// that adds and manipulates fish in one large list.
void bruteForce(List<int> fishList, int days) {
  List<int> fishListCopy = [...fishList];
  for (int i = 0; i < days; i++) {
    int newFish = 0;

    for (int f = 0; f < fishListCopy.length; f++) {
      if (fishListCopy[f] == 0) {
        newFish += 1;
        fishListCopy[f] = 6;
      } else {
        fishListCopy[f] -= 1;
      }
    }

    for (int i = 0; i < newFish; i++) {
      fishListCopy.add(8);
    }
  }
  print(fishListCopy.length);
}

// A elegant function for a more civilized approach. Tracks each generation of
// fish based on the current day in their reproduction cycle. Increases the
// total every time by the number of reproducing fish.
void generationTracker(List<int> fishList, int days) {
  Map<int, int> generation = {
    0: 0,
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
  };

  int totalFish = fishList.length;

  // Update generations for the starting fish.
  fishList.forEach((fish) {
    generation[fish] += 1;
  });

  for (int i = 0; i < days; i++) {
    int reproducingFish = generation[0];

    // Move each generation count down to the next generation.
    generation[0] = generation[1];
    generation[1] = generation[2];
    generation[2] = generation[3];
    generation[3] = generation[4];
    generation[4] = generation[5];
    generation[5] = generation[6];
    generation[6] = generation[7];
    generation[7] = generation[8];

    // Increase gen 6 by the number of reproducing fish.
    generation[6] += reproducingFish;
    // Increase gen 8 for each fish that reproduced.
    generation[8] = reproducingFish;
    // Increase the total by the new fish.
    totalFish += reproducingFish;
  }

  print(totalFish);
}

void main() async {
  final File file = File(Directory.current.path + '/day_6/input.txt');
  List<int> values = await file.readAsLines().then((lines) {
    List<String> stringList = lines[0].split(',');
    List<int> ints = [];
    for (String value in stringList) {
      ints.add(int.parse(value));
    }
    return ints;
  });

  //! PART 1
  bruteForce(values, 80);

  //! PART 2
  generationTracker(values, 256);
}
