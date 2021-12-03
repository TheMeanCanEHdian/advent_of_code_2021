// https://adventofcode.com/2021/day/2

import 'dart:io';

main() async {
  final File file = File(Directory.current.path + '/day_2/input.txt');
  List<String> values = await file.readAsLines();

  List<List> commands = [];
  values.forEach((value) {
    commands.add(value.split(' '));
  });

  //! PART 1
  int horizontal = 0;
  int depth = 0;

  commands.forEach((command) {
    int unit = int.parse(command[1]);

    switch (command[0]) {
      case 'forward':
        horizontal += unit;
        break;
      case 'up':
        depth -= unit;
        break;
      case 'down':
        depth += unit;
    }
  });

  print(horizontal * depth);

  //! PART 2
  horizontal = 0;
  depth = 0;
  int aim = 0;

  commands.forEach((command) {
    int unit = int.parse(command[1]);

    switch (command[0]) {
      case 'forward':
        horizontal += unit;
        depth += (unit * aim);
        break;
      case 'up':
        aim -= unit;
        break;
      case 'down':
        aim += unit;
    }
  });

  print(horizontal * depth);
}
