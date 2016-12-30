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
