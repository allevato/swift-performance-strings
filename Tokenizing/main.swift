do {
  // Measure the Character-based tokenizer.
  try measure("CharacterBasedTokenizer") {
    for _ in 0..<1000 {
      var tokenizer = CharacterBasedTokenizer(text: stateDataString)
      while let token = try tokenizer.nextToken() {}
    }
  }

  // Measure the UnicodeScalar-based tokenizer.
  try measure("UnicodeScalarBasedTokenizer") {
    for _ in 0..<1000 {
      var tokenizer = UnicodeScalarBasedTokenizer(text: stateDataString)
      while let token = try tokenizer.nextToken() {}
    }
  }
} catch let e {
  fatalError("Error was thrown: \(e)")
}
