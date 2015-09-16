import MusicKit

let unalteredTetrads = ChordQuality.UnalteredTetrads
let diminishedTetrads = [ChordQuality.DiminishedSeventh, ChordQuality.HalfDiminishedSeventh]
let augmentedTetrads = [ChordQuality.AugmentedSeventh, ChordQuality.AugmentedMajorSeventh]
var nonDiminishedTetrads = unalteredTetrads.filter {
    !contains(diminishedTetrads, $0)
}
var nonAugmentedTetrads = unalteredTetrads.filter {
    !contains(augmentedTetrads, $0)
}
var nonDiminishedAugmentedTetrads = unalteredTetrads.filter {
    !contains(diminishedTetrads + augmentedTetrads, $0)
}

var flatNines = ([String](), [String]())
for q in unalteredTetrads {
    var name = q.name.stringByReplacingOccurrencesOfString("Seventh", withString: "Eleventh")
    name = name + "FlatNine"
    var symbol = q.description.stringByReplacingOccurrencesOfString("7", withString: "11")
    symbol = symbol + "♭9"
    var symbolLine = "case \(name) = \"\(symbol)\""
    flatNines.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.FlatNine.rawValue),
                Float(ChordExtension.Eleven.rawValue)])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    flatNines.1.append(intervalLine)
}

var sharpElevens = ([String](), [String]())
for q in nonDiminishedTetrads {
    var name = q.name.stringByReplacingOccurrencesOfString("Seventh", withString: "Ninth")
    name = name + "SharpEleven"
    var symbol = q.description.stringByReplacingOccurrencesOfString("7", withString: "9")
    symbol = symbol + "♯11"
    var symbolLine = "case \(name) = \"\(symbol)\""
    sharpElevens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.Nine.rawValue),
                Float(ChordExtension.SharpEleven.rawValue)])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    sharpElevens.1.append(intervalLine)
}

var flatThirteens = ([String](), [String]())
for q in nonAugmentedTetrads {
    var name = q.name.stringByReplacingOccurrencesOfString("Seventh", withString: "Ninth")
    name = name + "FlatThirteen"
    var symbol = q.description.stringByReplacingOccurrencesOfString("7", withString: "9")
    symbol = symbol + "♭13"
    var symbolLine = "case \(name) = \"\(symbol)\""
    flatThirteens.0.append(symbolLine)

    var intervals = MKUtil.intervals(
        MKUtil.semitoneIndices(q.intervals) +
            [Float(ChordExtension.Nine.rawValue),
                Float(ChordExtension.FlatThirteen.rawValue)])
    var intIntervals = [Int]()
    for i in intervals { intIntervals.append(Int(i)) }
    var intervalLine = "case \(name): return \(intIntervals)"
    flatThirteens.1.append(intervalLine)
}

func printCode(groupName: String, symbols: [String], intervals: [String]) {
    print("// \(groupName)\n")
    symbols.map { print("\($0)\n") }
    print("\n")
    print("// \(groupName)\n")
    intervals.map { print("\($0)\n") }
    print("\n")
}

printCode("flat nine hexads", flatNines.0, flatNines.1)
printCode("sharp eleven hexads", sharpElevens.0, sharpElevens.1)
printCode("flat thirteen hexads", flatThirteens.0, flatThirteens.1)
