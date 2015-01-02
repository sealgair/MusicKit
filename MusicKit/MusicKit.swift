//  Copyright (c) 2015 Ben Guo. All rights reserved.

extension Array {
    func rotate(n: Int) -> [T] {
        let count = self.count
        let index = n % count
        return Array(self[index..<count] + self[0..<index])
    }
}

public struct MusicKit {
    public static var concertA : Double = 440.0
}