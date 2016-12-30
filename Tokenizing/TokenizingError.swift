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
