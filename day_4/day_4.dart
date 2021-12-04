// https://adventofcode.com/2021/day/4

import 'dart:io';

// Parse input to create a list of bingo board matrices. Each bingo board (list)
// is 5 lists (rows) each with 5 values.
List<List<List<String>>> createBingoBoards(List<String> input) {
  List<List<List<String>>> bingoBoards = [];

  List<List<String>> currentBoard = [];
  input.forEach((row) {
    // When a blank row is hit add the current board to bingoBoards and reset
    // currentBoard.
    if (row == '') {
      bingoBoards.add(currentBoard);
      currentBoard = [];
    } else {
      // Parse each row of the bingo board and remove any whitespace or blank
      // values.
      List<String> parsedRow =
          row.trim().split(' ').map((value) => value.trim()).toList();
      parsedRow.removeWhere((value) => value == '');

      currentBoard.add(parsedRow);
    }
  });

  return bingoBoards;
}

List<List<String>>? checkForWinningBoard(
  List<List<List<String>>> activeBoards,
) {
  for (var b = 0; b < activeBoards.length; b++) {
    // Check for horizontal win by looking for 5 `!` in one row.
    for (var r = 0; r < activeBoards[b].length; r++) {
      int count =
          activeBoards[b][r].where((value) => value == '!').toList().length;

      if (count == 5) {
        return activeBoards[b];
      }
    }

    // Check for vertical win by looking for 5 `!` across all rows at an index.
    for (var i = 0; i < 5; i++) {
      int count = 0;

      for (var r = 0; r < activeBoards[b].length; r++) {
        if (activeBoards[b][r][i] == '!') {
          count += 1;
        }
      }

      if (count == 5) {
        return activeBoards[b];
      }
    }
  }

  return null;
}

int calculateScore(String winningNumber, List<List<String>> winningBoard) {
  int unmarkedSum = 0;

  for (List<String> row in winningBoard) {
    for (String value in row) {
      if (value != '!') {
        unmarkedSum += int.parse(value);
      }
    }
  }

  return unmarkedSum * int.parse(winningNumber);
}

void winBingo(
  List<String> bingoNumbers,
  List<List<List<String>>> bingoBoards,
) {
  List<List<List<String>>> activeBoards = [...bingoBoards];

  // Replace number on active boiard with `!` when picked.
  for (var n = 0; n < bingoNumbers.length; n++) {
    for (var b = 0; b < bingoBoards.length; b++) {
      for (var r = 0; r < bingoBoards[b].length; r++) {
        for (var v = 0; v < bingoBoards[b][r].length; v++) {
          if (bingoBoards[b][r][v] == bingoNumbers[n]) {
            activeBoards[b][r][v] = '!';
          }
        }
      }
    }

    // Check if a board has won starting once 5 numbers have been drawn.
    if (n > 4) {
      List<List<String>>? winningBoard = checkForWinningBoard(activeBoards);
      if (winningBoard != null) {
        print('First Winning Board & Score');
        print(winningBoard);
        print(calculateScore(bingoNumbers[n], winningBoard));
        break;
      }
    }
  }
}

void loseBingo(
  List<String> bingoNumbers,
  List<List<List<String>>> bingoBoards,
) {
  List<List<List<String>>> activeBoards = [...bingoBoards];
  List<List<List<String>>> winningBoards = [];
  String lastWinningBingoNumber = '';

  // Replace number on active boiard with `!` when picked.
  for (var n = 0; n < bingoNumbers.length; n++) {
    for (var b = 0; b < activeBoards.length; b++) {
      for (var r = 0; r < activeBoards[b].length; r++) {
        for (var v = 0; v < activeBoards[b][r].length; v++) {
          if (activeBoards[b][r][v] == bingoNumbers[n]) {
            activeBoards[b][r][v] = '!';
          }
        }
      }

      // Check if a board has won starting once 5 numbers have been drawn.
      if (n > 4) {
        List<List<String>>? winningBoard = checkForWinningBoard(activeBoards);
        if (winningBoard != null) {
          winningBoards.add(winningBoard);
          lastWinningBingoNumber = bingoNumbers[n];
          activeBoards.removeAt(b);
          b -= 1;
        }
      }
    }
  }
  print('Last Winning Board & Score');
  print(winningBoards.last);
  print(calculateScore(lastWinningBingoNumber, winningBoards.last));
}

main() async {
  final File file = File(Directory.current.path + '/day_4/input.txt');
  List<String> values = await file.readAsLines();

  List<String> bingoNumbers = values[0].split(',');

  List<List<List<String>>> bingoBoards = createBingoBoards(values.sublist(2));

  //! PART 1
  winBingo(bingoNumbers, bingoBoards);

  //! PART 2
  loseBingo(bingoNumbers, bingoBoards);
}
