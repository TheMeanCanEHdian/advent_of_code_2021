// https://adventofcode.com/2021/day/8

// Removing null safety as its being a huge pain when it comes to referencing
// the segments map in determineSignalMappings().
// @dart=2.9
import 'dart:io';

// Returns the first shared segment betwen two signals.
String commonSegment(String signalOne, String signalTwo) {
  Set<String> signalOneSet = signalOne.split('').toSet();
  Set<String> signalTwoSet = signalTwo.split('').toSet();

  return signalOneSet.intersection(signalTwoSet).first;
}

// Returns `true` if `currentSignal` contains every character in
// `signalToCheckAgainst`.
bool checkIfContainsSignal(String currentSignal, String signalToCheckAgainst) {
  if (signalToCheckAgainst.split('').every(
        (element) => currentSignal.split('').contains(element),
      )) {
    return true;
  }

  return false;
}

// Uses a variety of logic to determine which signal maps to what number.
Map<int, String> determineSignalMappings(
  List<String> signalMappings, {
  Map<int, String> knownMappings,
}) {
  signalMappings.sort((a, b) => a.length.compareTo(b.length));

  Map<int, String> signals = knownMappings ?? {};

  signalMappings.forEach((signal) {
    // 1 will be the only value with 2 segments
    if (signal.length == 2) {
      signals[1] = signal;
    }
    // 4 will be the only value with 4 segments
    else if (signal.length == 4) {
      signals[4] = signal;
    }
    // 7 will be the only value with 3 segments
    else if (signal.length == 3) {
      signals[7] = signal;
    }
    // 8 will be the only value with 7 segments
    else if (signal.length == 7) {
      signals[8] = signal;
    }
    // 3 will be the only value with 5 segments and have all of 1's segments
    else if (signal.length == 5 && checkIfContainsSignal(signal, signals[1])) {
      signals[3] = signal;
    }
    // 0, 6, and 9 will have 6 segments
    else if (signal.length == 6) {
      // 9 will be the only value with 6 segments and all of 3's and 4's
      // segments
      if (checkIfContainsSignal(signal, signals[3]) &&
          checkIfContainsSignal(signal, signals[4])) {
        signals[9] = signal;
      }
      // 0 will be the only remaining value with 6 segments and all of 1's
      else if (checkIfContainsSignal(signal, signals[1])) {
        signals[0] = signal;
      }
      // 6 is the only remaining value with 6 segments
      else {
        signals[6] = signal;
      }
    } else {
      try {
        String segment = commonSegment(signals[1], signals[6]);
        // If signal contains at least 1 segment shared by signal 1 and signal 6
        // then it has to be signal 5. Otherwise, it has to be signal 2.
        if (signal.contains(segment)) {
          signals[5] = signal;
        } else {
          signals[2] = signal;
        }
      } catch (e) {}
    }
  });

  return signals;
}

// Builds signal mappings. If the returned signal mapping length is less than
// 10 use the current signal map to calculate the missing mappings.
Map<int, String> buildSignalMapping(List<String> signalMappings) {
  Map<int, String> signalMap = determineSignalMappings(signalMappings);

  if (signalMap.length < 10) {
    signalMap =
        determineSignalMappings(signalMappings, knownMappings: signalMap);
  }

  return signalMap;
}

// Uses built signal mappings to decode the output value.
int calculateOutputValue(List<List<String>> input) {
  Map<int, String> signalMappings = buildSignalMapping(input[0]);

  String finalOutput = '';

  input[1].forEach((output) {
    signalMappings.forEach((key, value) {
      if (output.length == value.length) {
        // If all output values are in signal mapping
        bool match = output.split('').every((c) => value.contains(c));
        if (match) {
          finalOutput += '$key';
        }
      }
    });
  });

  return int.parse(finalOutput);
}

// Each input is turned into 2 lists. The left and right side of `|`. These
// lists are then all added to one larger list.
List<List<List<String>>> formatInput(List<String> input) {
  List<List<List<String>>> formattedInput = [];

  input.forEach((line) {
    List<List<String>> temp = [];

    List<String> splitLine = line.split(' | ');
    splitLine.forEach((signal) {
      temp.add(signal.split(' '));
    });

    formattedInput.add(temp);
  });

  return formattedInput;
}

void main() async {
  final File file = File(Directory.current.path + '/day_8/input.txt');
  List<String> input = await file.readAsLines();

  List<List<List<String>>> formattedInput = formatInput(input);

  //! PART 1
  int occurances = 0;

  formattedInput.forEach((row) {
    row[1].forEach((outputValue) {
      // If digit is a 1, 4, 7, or 8 (detemined by length)
      if ([2, 4, 3, 7].contains(outputValue.length)) {
        occurances += 1;
      }
    });
  });

  print(occurances);

  //! PART 2
  int outputSum = 0;

  formattedInput.forEach((input) {
    outputSum += calculateOutputValue(input);
  });

  print(outputSum);
}
