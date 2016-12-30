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


/// Contrived sample data for our tokenizing measurements.
let stateDataString =
  "\"California\", 39250017, \"Sacramento\";\n" +
  "\"Texas\", 27862596, \"Austin\";\n" +
  "\"Florida\", 20612439, \"Tallahassee\";\n" +
  "\"New York\", 19745289, \"Albany\";\n" +
  "\"Illinois\", 12801539, \"Springfield\";\n" +
  "\"Pennsylvania\", 12784227, \"Harrisburg\";\n" +
  "\"Ohio\", 11614373, \"Columbus\";\n" +
  "\"Georgia\", 10310371, \"Atlanta\";\n" +
  "\"North Carolina\", 10146788, \"Raleigh\";\n" +
  "\"Michigan\", 9928301, \"Lansing\";\n" +
  "\"New Jersey\", 8944469, \"Trenton\";\n" +
  "\"Virginia\", 8411808, \"Richmond\";\n" +
  "\"Washington\", 7288000, \"Olympia\";\n" +
  "\"Arizona\", 6931071, \"Phoenix\";\n" +
  "\"Massachusetts\", 6811779, \"Boston\";\n" +
  "\"Tennessee\", 6651194, \"Nashville\";\n" +
  "\"Indiana\", 6633053, \"Indianapolis\";\n" +
  "\"Missouri\", 6093000, \"Jefferson City\";\n" +
  "\"Maryland\", 6016447, \"Annapolis\";\n" +
  "\"Wisconsin\", 5778708, \"Madison\";\n" +
  "\"Colorado\", 5540545, \"Denver\";\n" +
  "\"Minnesota\", 5519952, \"Saint Paul\";\n" +
  "\"South Carolina\", 4961119, \"Columbia\";\n" +
  "\"Alabama\", 4863300, \"Montgomery\";\n" +
  "\"Louisiana\", 4681666, \"Baton Rouge\";\n" +
  "\"Kentucky\", 4436974, \"Frankfort\";\n" +
  "\"Oregon\", 4093465, \"Salem\";\n" +
  "\"Oklahoma\", 3923561, \"Oklahoma City\";\n" +
  "\"Connecticut\", 3576452, \"Hartford\";\n" +
  "\"Iowa\", 3134693, \"Des Moines\";\n" +
  "\"Utah\", 3051217, \"Salt Lake City\";\n" +
  "\"Mississippi\", 2988726, \"Jackson\";\n" +
  "\"Arkansas\", 2988248, \"Little Rock\";\n" +
  "\"Nevada\", 2940058, \"Carson City\";\n" +
  "\"Kansas\", 2907289, \"Topeka\";\n" +
  "\"New Mexico\", 2081015, \"Santa Fe\";\n" +
  "\"Nebraska\", 1907116, \"Lincoln\";\n" +
  "\"West Virginia\", 1831102, \"Charleston\";\n" +
  "\"Idaho\", 1683140, \"Boise\";\n" +
  "\"Hawaii\", 1428557, \"Honolulu\";\n" +
  "\"New Hampshire\", 1334795, \"Concord\";\n" +
  "\"Maine\", 1331479, \"Augusta\";\n" +
  "\"Rhode Island\", 1056426, \"Providence\";\n" +
  "\"Montana\", 1042520, \"Helena\";\n" +
  "\"Delaware\", 945934, \"Dover\";\n" +
  "\"South Dakota\", 865454, \"Pierre\";\n" +
  "\"North Dakota\", 757952, \"Bismarck\";\n" +
  "\"Alaska\", 738432, \"Juneau\";\n" +
  "\"Vermont\", 624594, \"Montpelier\";\n" +
  "\"Wyoming\", 585501, \"Cheyenne\";\n"
