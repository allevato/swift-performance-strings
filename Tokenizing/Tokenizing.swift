/// The common interface provided by all tokenizers.
protocol Tokenizing {

  /// Creates a new tokenizer that scans the given string.
  ///
  /// - Parameter text: The text to tokenize.
  init(text: String)

  /// Returns the next token from the input string.
  ///
  /// - Returns: The next token from the input string, or nil if the end of the
  ///   string has been reached.
  /// - Throws: A `TokenizeError` if an unexpected error occurred during
  ///   tokenization, like a malformed integer or unrecognized character.
  mutating func nextToken() throws -> Token?
}
