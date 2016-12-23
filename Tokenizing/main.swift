do {
  // Measure the Character-based tokenizer.
  try measure("CharacterBasedTokenizer") {
    for _ in 0..<1000 {
      var tokenizer = CharacterBasedTokenizer(text: stateDataString)
      while let token = try tokenizer.nextToken() {}
    }
  }
} catch let e {
  fatalError("Error was thrown: \(e)")
}
