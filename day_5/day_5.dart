// https://adventofcode.com/2021/day/5

import 'dart:io';
import 'dart:math';

// Counts all points on the grid larger than 1.
int overlappingPointCount(List<List<int>> coordinateGrid) {
  int count = 0;

  coordinateGrid.forEach((row) {
    row.forEach((point) {
      if (point > 1) {
        count += 1;
      }
    });
  });

  return count;
}

// Draw lines by increasing the value on the grid by 1 for each point a
// line crosses.
List<List<int>> drawLines(
  List<Map<String, int>> ventList,
  List<List<int>> coordinateGrid,
) {
  List<List<int>> gridCopy = [...coordinateGrid];

  for (Map<String, int> vent in ventList) {
    // Vertical lines
    if (vent['x1'] == vent['x2']) {
      for (var y = [vent['y1']!, vent['y2']!].reduce(min);
          y <= [vent['y1']!, vent['y2']!].reduce(max);
          y++) {
        gridCopy[y][vent['x1']!] += 1;
      }
    }

    // Horizontal lines
    if (vent['y1'] == vent['y2']) {
      for (var x = [vent['x1']!, vent['x2']!].reduce(min);
          x <= [vent['x1']!, vent['x2']!].reduce(max);
          x++) {
        gridCopy[vent['y1']!][x] += 1;
      }
    }

    // Diagonal lines
    if (vent['x1'] != vent['x2'] && vent['y1'] != vent['y2']) {
      // Bottom left to top right
      if (vent['x1']! > vent['x2']! && vent['y1']! < vent['y2']!) {
        for (var i = 0; i <= vent['x1']! - vent['x2']!; i++) {
          int x = vent['x1']! - i;
          int y = vent['y1']! + i;
          gridCopy[y][x] += 1;
        }
      }
      // Bottom right to top left
      if (vent['x1']! > vent['x2']! && vent['y1']! > vent['y2']!) {
        for (var i = 0; i <= vent['x1']! - vent['x2']!; i++) {
          int x = vent['x1']! - i;
          int y = vent['y1']! - i;
          gridCopy[y][x] += 1;
        }
      }
      // top left to bottom right
      if (vent['x1']! < vent['x2']! && vent['y1']! < vent['y2']!) {
        for (var i = 0; i <= vent['x2']! - vent['x1']!; i++) {
          int x = vent['x1']! + i;
          int y = vent['y1']! + i;
          gridCopy[y][x] += 1;
        }
      }
      // top right to bottom left
      if (vent['x1']! < vent['x2']! && vent['y1']! > vent['y2']!) {
        for (var i = 0; i <= vent['x2']! - vent['x1']!; i++) {
          int x = vent['x1']! + i;
          int y = vent['y1']! - i;
          gridCopy[y][x] += 1;
        }
      }
    }
  }

  return gridCopy;
}

// Create a grid from 0,0 to the largest x2,y2 values.
List<List<int>> createGrid(List<Map<String, int>> ventList) {
  List<int> xCoordinates = [];
  List<int> yCoordinates = [];

  ventList.forEach((vent) {
    xCoordinates.add(vent['x1']!);
    yCoordinates.add(vent['x2']!);
    xCoordinates.add(vent['y1']!);
    yCoordinates.add(vent['y2']!);
  });

  int xMax = xCoordinates.reduce(max);
  int yMax = yCoordinates.reduce(max);

  List<List<int>> coordinateGrid = [];

  for (var y = 0; y <= yMax; y++) {
    List<int> row = [];
    for (var x = 0; x <= xMax; x++) {
      row.add(0);
    }
    coordinateGrid.add(row);
  }

  return coordinateGrid;
}

// Parse vents into map of individual coordinates.
List<Map<String, int>> parseVents(List<String> vents) {
  List<Map<String, int>> ventList = [];

  // Parse input
  vents.forEach((vent) {
    Map<String, int> ventMap = {};

    List<String> positions = vent.split(' -> ');

    List<String> x1y1 = positions[0].split(',');
    List<String> x2y2 = positions[1].split(',');

    ventMap['x1'] = int.parse(x1y1[0]);
    ventMap['y1'] = int.parse(x1y1[1]);
    ventMap['x2'] = int.parse(x2y2[0]);
    ventMap['y2'] = int.parse(x2y2[1]);

    ventList.add(ventMap);
  });

  return ventList;
}

void main() async {
  final File file = File(Directory.current.path + '/day_5/input.txt');
  List<String> vents = await file.readAsLines();

  List<Map<String, int>> ventList = parseVents(vents);
  // Creating the coordinateGrid and referencing it in both PART 1 and PART 2
  // breaks something in PART 2 and I don't care enough to tshoot.
  // List<List<int>> coordinateGrid = createGrid(ventList);

  //! PART 1
  // Filter out vents that are not horizontal or vertical.
  List<Map<String, int>> filteredVents = [];
  ventList.forEach((vent) {
    if (vent['x1'] == vent['x2'] || vent['y1'] == vent['y2']) {
      filteredVents.add(vent);
    }
  });

  // List<List<int>> part1Grid = drawLines(filteredVents, createGrid(ventList));
  List<List<int>> part1Grid = drawLines(filteredVents, createGrid(ventList));
  print(overlappingPointCount(part1Grid));

  //! PART 2
  // List<List<int>> part2Grid = drawLines(ventList, createGrid(ventList));
  List<List<int>> part2Grid = drawLines(ventList, createGrid(ventList));
  print(overlappingPointCount(part2Grid));
}
