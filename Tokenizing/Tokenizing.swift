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
