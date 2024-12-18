// return X or O if there is a winner
// return '' if no winner yet
// return null if game draw

String? checkWinner(List<String> cellValues) {
  // Check horizontally
  for (int i = 0; i < 3; i++) {
    if (cellValues[3 * i] != '' &&
        cellValues[3 * i] == cellValues[3 * i + 1] &&
        cellValues[3 * i] == cellValues[3 * i + 2]) {
      return cellValues[3 * i];
    }
  }

  // Check vertically
  for (int i = 0; i < 3; i++) {
    if (cellValues[i] != '' &&
        cellValues[i] == cellValues[3 + i] &&
        cellValues[i] == cellValues[i + 6]) {
      return cellValues[i];
    }
  }

  // Top left to botton right diagonal
  if (cellValues[0] != '' &&
      cellValues[0] == cellValues[4] &&
      cellValues[0] == cellValues[8]) {
    return cellValues[0];
  }

  // Top right to botton left diagonal
  if (cellValues[2] != '' &&
      cellValues[2] == cellValues[4] &&
      cellValues[2] == cellValues[6]) {
    return cellValues[2];
  }

  // Check is all values are filled
  if (cellValues.contains('')) {
    return '';
  }

  return null;
}
