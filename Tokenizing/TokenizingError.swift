/// Errors thrown a problem is encountered while tokenizing a string.
enum TokenizingError: Error {

  /// A token that looked like an integer could not be converted to `Int`.
  case malformedInteger

  /// A character was found in the input string that is not recognized by the
  /// tokenizer.
  case unrecognizedCharacter

  /// The end of the input string was reached while scanning a quoted string.
  case unterminatedString
}
