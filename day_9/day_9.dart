// https://adventofcode.com/2021/day/9

import 'dart:io';

List<int> getLowestPoints(List<List<int>> values) {
  List<int> lowestPoints = [];

  for (int y = 0; y < values.length; y++) {
    for (int x = 0; x < values[y].length; x++) {
      int currentValue = values[y][x];

      // Make sure we are not at the top, bottom, left, or right of the grid.
      // This lets us check all surrounding values freely.
      if (y != 0 &&
          y != values.length - 1 &&
          x != 0 &&
          x != values[y].length - 1) {
        int left = values[y][x - 1];
        int right = values[y][x + 1];
        int top = values[y - 1][x];
        int bottom = values[y + 1][x];

        bool lowest = currentValue < left &&
            currentValue < right &&
            currentValue < top &&
            currentValue < bottom;

        if (lowest) {
          lowestPoints.add(currentValue);
        }
      }
      // Now we are working with the edges so we have to be smart about checking
      // the surrounding values.
      else {
        //* Check Corners
        // Top left
        if (y == 0 && x == 0) {
          int right = values[y][x + 1];
          int bottom = values[y + 1][x];

          bool lowest = currentValue < right && currentValue < bottom;

          if (lowest) {
            lowestPoints.add(currentValue);
          }
        }
        // Top Right
        else if (y == 0 && x == values[y].length - 1) {
          int left = values[y][x - 1];
          int bottom = values[y + 1][x];

          bool lowest = currentValue < left && currentValue < bottom;

          if (lowest) {
            lowestPoints.add(currentValue);
          }
        }
        // Bottom left
        else if (y == values.length - 1 && x == 0) {
          int top = values[y - 1][x];
          int right = values[y][x + 1];

          bool lowest = currentValue < right && currentValue < top;

          if (lowest) {
            lowestPoints.add(currentValue);
          }
        }
        // Bottom right
        else if (y == values.length - 1 && x == values[y].length - 1) {
          int top = values[y - 1][x];
          int left = values[y][x - 1];

          bool lowest = currentValue < left && currentValue < top;

          if (lowest) {
            lowestPoints.add(currentValue);
          }
        }
        //* Check Sides
        // Top side
        else if (y == 0) {
          int left = values[y][x - 1];
          int right = values[y][x + 1];
          int bottom = values[y + 1][x];

          bool lowest = currentValue < left &&
              currentValue < right &&
              currentValue < bottom;

          if (lowest) {
            lowestPoints.add(currentValue);
          }
        }
        // Bottom side
        else if (y == values.length - 1) {
          int left = values[y][x - 1];
          int right = values[y][x + 1];
          int top = values[y - 1][x];

          bool lowest =
              currentValue < left && currentValue < right && currentValue < top;

          if (lowest) {
            lowestPoints.add(currentValue);
          }
        }
        // Left side
        else if (x == 0) {
          int right = values[y][x + 1];
          int top = values[y - 1][x];
          int bottom = values[y + 1][x];

          bool lowest = currentValue < right &&
              currentValue < top &&
              currentValue < bottom;

          if (lowest) {
            lowestPoints.add(currentValue);
          }
        }
        // Right side
        else if (x == values[y].length - 1) {
          int left = values[y][x - 1];
          int top = values[y - 1][x];
          int bottom = values[y + 1][x];

          bool lowest = currentValue < left &&
              currentValue < top &&
              currentValue < bottom;

          if (lowest) {
            lowestPoints.add(currentValue);
          }
        }
      }
    }
  }

  return lowestPoints;
}

main() async {
  final File file = File(Directory.current.path + '/day_9/test.txt');
  List<List<int>> values = await file.readAsLines().then((lines) {
    List<List<int>> ints = [];
    lines.forEach((line) {
      List<String> stringList = line.split('');
      List<int> temp = [];
      for (String value in stringList) {
        temp.add(int.parse(value));
      }
      ints.add(temp);
    });
    return ints;
  });

  //! PART 1
  List<int> lowestPoints = getLowestPoints(values);
  print(lowestPoints.reduce((a, b) => a + b) + lowestPoints.length);
}
