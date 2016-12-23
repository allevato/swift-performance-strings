/// Kinds of tokens recognized and returned by the tokenizer.
enum Token {

  /// A quoted string. The string associated with this value does *not* contain
  /// the surrounding quotes from the original text.
  case string(String)

  /// An integer.
  case integer(Int)

  /// A comma.
  case comma

  /// A semicolon.
  case semicolon
}
