// https://adventofcode.com/2021/day/3

import 'dart:io';

enum CommonType {
  most,
  least,
}

// Calculates a new binary value based on the most common value at each index
String calculateCommon(
  List<String> values, {
  required CommonType commonType,
}) {
  String common = '';

  // Split values into lists of individual binary values
  List<List<String>> splitLists = [];

  values.forEach((value) {
    splitLists.add(value.trim().split(''));
  });

  // Group binary values by index
  List<String> groupedBitsStrings = [];

  splitLists.forEach((list) {
    for (var i = 0; i < list.length; i++) {
      // Add an empty string for index if missing
      if (groupedBitsStrings.length < i + 1) {
        groupedBitsStrings.add('');
      }

      groupedBitsStrings[i] += list[i];
    }
  });

  // Calculate the most common bits for each index and add to common string
  groupedBitsStrings.forEach((indexGroup) {
    int zeroCount = '0'.allMatches(indexGroup).length;
    int oneCount = '1'.allMatches(indexGroup).length;

    switch (commonType) {
      case (CommonType.most):
        if (zeroCount > oneCount) {
          common += '0';
        } else {
          common += '1';
        }
        break;
      case (CommonType.least):
        if (zeroCount <= oneCount) {
          common += '0';
        } else {
          common += '1';
        }
        break;
    }
  });

  return common;
}

main() async {
  final File file = File(Directory.current.path + '/day_3/input.txt');
  List<String> values = await file.readAsLines();

  //! PART 1
  String mostCommon = calculateCommon(values, commonType: CommonType.most);
  String leastCommon = calculateCommon(values, commonType: CommonType.least);

  // Convert to decimal from binary
  int gamma = int.parse(mostCommon, radix: 2);
  int epsilon = int.parse(leastCommon, radix: 2);

  print(gamma * epsilon);

  //! PART 2
  // Create copies of values for oxygen and c02
  List<String> oxygenValues = [...values];
  List<String> c02Values = [...values];

  // Loop for each index
  for (var i = 0; i < values[0].length; i++) {
    // Recalculate common result based on current oxygen and c02 values
    String currentMostCommon = calculateCommon(
      oxygenValues,
      commonType: CommonType.most,
    );
    String currentLeastCommon = calculateCommon(
      c02Values,
      commonType: CommonType.least,
    );

    // Remove values that to not match the current index
    if (oxygenValues.length > 1) {
      oxygenValues.removeWhere((value) => value[i] != currentMostCommon[i]);
    }
    if (c02Values.length > 1) {
      c02Values.removeWhere((value) => value[i] != currentLeastCommon[i]);
    }
  }

  // Convert to decimal from binary
  final int oxygenGenRating = int.parse(oxygenValues[0], radix: 2);
  final int c02GenRating = int.parse(c02Values[0], radix: 2);

  print(oxygenGenRating * c02GenRating);
}
