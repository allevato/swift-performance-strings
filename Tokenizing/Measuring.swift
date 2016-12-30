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


import Darwin

/// The number of measurements that should be taken in each call to `measure`.
private let numberOfMeasurements = 5

/// The number of nanoseconds in one millisecond (10^6).
private let nanosPerMilli = 1_000_000

/// Executes a block a number of times, measuring its execution time, and then
/// prints a summary of the results (its mean and standard deviation).
///
/// - Parameter description: The description of the block being measured, which
///   is printed in the summary output.
/// - Parameter block: The block that should be executed and measured.
/// - Throws: Any error that the measured block may throw.
func measure(_ description: String, block: () throws -> Void) rethrows {
  var timebase = mach_timebase_info_data_t()
  guard mach_timebase_info(&timebase) == KERN_SUCCESS else {
    fatalError("mach_timebase_info failed; not much we can do about that.")
  }

  print("\(description):")

  // Run the block a couple times to "prime" the benchmark; this avoids the
  // first runs being outliers due to data that might be loaded lazily.
  for _ in 0..<2 {
    _ = try block()
  }

  var timings = [Double]()

  for _ in 0..<numberOfMeasurements {
    print(".", terminator: "")

    let start = mach_absolute_time()
    try block()
    let end = mach_absolute_time()

    let elapsedUnits = end - start

    let elapsedMillis = (Double(elapsedUnits) *
      Double(timebase.numer) / Double(timebase.denom)) / Double(nanosPerMilli)
    timings.append(elapsedMillis)
  }

  let (mean, stddev) = statistics(timings)
  print(" \(mean) ms ± \(stddev) ms (mean ± SD)")
}

/// Returns the mean and standard deviation of the given timings.
///
/// - Parameter timings: The array of timings whose statistics should be
///   calculated.
/// - Returns: A tuple `(mean, stddev)` containing the mean of the given array
///   and its standard deviation.
private func statistics(_ timings: [Double]) -> (mean: Double, stddev: Double) {
  var sum: Double = 0
  var sqsum: Double = 0
  for timing in timings {
    sum += timing
    sqsum += timing * timing
  }
  let n = Double(timings.count)
  let mean = sum / n
  let variance = sqsum / n - mean * mean
  return (mean: mean, stddev: sqrt(variance))
}
