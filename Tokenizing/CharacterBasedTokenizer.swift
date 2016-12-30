// Copyright 2016 Tony Allevato
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


/// A tokenizer that works with the character views of strings.
struct CharacterBasedTokenizer: Tokenizing {

  /// Used during scanning to return each character in the string.
  private var iterator: String.CharacterView.Iterator

  /// If non-nil, this character will be returned by the next call to
  /// `nextCharacter`. This allows the tokenizer to detect the end of a token
  /// based on characters that are not part of that token, and then push the
  /// character back so that it can be read as the first character of the next
  /// token.
  private var pushedBackCharacter: Character?

  /// Creates a new character-based tokenizer that scans the given string.
  ///
  /// - Parameter text: The text to tokenize.
  init(text: String) {
    iterator = text.characters.makeIterator()
  }

  /// Returns the next token from the input string.
  ///
  /// - Returns: The next token from the input string, or nil if the end of the
  ///   string has been reached.
  /// - Throws: A `TokenizeError` if an unexpected error occurred during
  ///   tokenization, like a malformed integer or unrecognized character.
  mutating func nextToken() throws -> Token? {
    while let ch = nextCharacter() {
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

  /// Returns the next character to process from the input string.
  ///
  /// If `pushedBackCharacter` is non-nil, that character will be returned and
  /// then that property is cleared. Otherwise, the iterator's next character is
  /// returned.
  ///
  /// - Returns: The next character to process, or nil if the end of the string
  ///   has been reached.
  private mutating func nextCharacter() -> Character? {
    if let next = pushedBackCharacter {
      pushedBackCharacter = nil
      return next
    }
    return iterator.next()
  }

  /// Scans the remainder of an integer token and returns it.
  ///
  /// - Parameter first: The first character of the integer that has already
  ///   been scanned.
  /// - Returns: A `Token.integer` whose associated value is the integer that
  ///   was scanned.
  /// - Throws: `TokenizeError.malformedInteger` if the scanned token text could
  ///   not be converted to an integer (for example, if it was too large).
  private mutating func integerToken(
    startingWith first: Character
    ) throws -> Token {
    var tokenText = String(first)

    loop: while let ch = nextCharacter() {
      switch ch {
      case "0"..."9":
        tokenText.append(ch)
      default:
        pushedBackCharacter = ch
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

    while let ch = nextCharacter() {
      switch ch {
      case "\"":
        return .string(tokenText)
      default:
        tokenText.append(ch)
      }
    }

    throw TokenizingError.unterminatedString
  }
}
