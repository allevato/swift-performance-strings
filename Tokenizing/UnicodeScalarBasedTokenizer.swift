/// A tokenizer that works with the Unicode scalar views of strings.
struct UnicodeScalarBasedTokenizer: Tokenizing {

  /// Used during scanning to return each Unicode scalar in the string.
  private var iterator: String.UnicodeScalarView.Iterator

  /// If non-nil, this scalar will be returned by the next call to `nextScalar`.
  /// This allows the tokenizer to detect the end of a token based on scalars
  /// that are not part of that token, and then push the scalar back so that it
  /// can be read as the first scalar of the next token.
  private var pushedBackScalar: UnicodeScalar?

  /// Creates a new `UnicodeScalar`-based tokenizer that scans the given string.
  ///
  /// - Parameter text: The text to tokenize.
  init(text: String) {
    iterator = text.unicodeScalars.makeIterator()
  }

  /// Returns the next token from the input string.
  ///
  /// - Returns: The next token from the input string, or nil if the end of the
  ///   string has been reached.
  /// - Throws: A `TokenizeError` if an unexpected error occurred during
  ///   tokenization, like a malformed integer or unrecognized character.
  mutating func nextToken() throws -> Token? {
    while let ch = nextScalar() {
      switch ch {
      case " ", "\n", "\r", "\t":
        // Ignore whitespace.
        continue
      case ",":
        return .comma
      case ";":
        return .semicolon
      case "0"..."9":
        return try integerToken(startingWith: ch)
      case "\"":
        return try stringToken()
      default:
        throw TokenizingError.unrecognizedCharacter
      }
    }
    return nil
  }

  /// Returns the next scalar to process from the input string.
  ///
  /// If `pushedBackScalar` is non-nil, that scalar will be returned and then
  /// that property is cleared. Otherwise, the iterator's next scalar is
  /// returned.
  ///
  /// - Returns: The next scalar to process, or nil if the end of the string has
  ///   been reached.
  private mutating func nextScalar() -> UnicodeScalar? {
    if let next = pushedBackScalar {
      pushedBackScalar = nil
      return next
    }
    return iterator.next()
  }

  /// Scans the remainder of an integer token and returns it.
  ///
  /// - Parameter first: The first scalar of the integer that has already been
  ///   scanned.
  /// - Returns: A `Token.integer` whose associated value is the integer that
  ///   was scanned.
  /// - Throws: `TokenizeError.malformedInteger` if the scanned token text could
  ///   not be converted to an integer (for example, if it was too large).
  private mutating func integerToken(
    startingWith first: UnicodeScalar
  ) throws -> Token {
    var tokenText = String(first)

    loop: while let ch = nextScalar() {
      switch ch {
      case "0"..."9":
        tokenText.unicodeScalars.append(ch)
      default:
        pushedBackScalar = ch
        break loop
      }
    }

    guard let value = Int(tokenText) else {
      throw TokenizingError.malformedInteger
    }
    return .integer(value)
  }

  /// Scans the remainder of a quoted string token and returns it.
  ///
  /// - Returns: A `Token.string` whose associated value is the string that was
  ///   quoted (without the surrounding quotes).
  /// - Throws: `TokenizeError.unterminatedString` if the end of the input was
  ///   reached without seeing a terminating quote.
  private mutating func stringToken() throws -> Token {
    var tokenText = String()

    while let ch = nextScalar() {
      switch ch {
      case "\"":
        return .string(tokenText)
      default:
        tokenText.unicodeScalars.append(ch)
      }
    }

    throw TokenizingError.unterminatedString
  }
}
