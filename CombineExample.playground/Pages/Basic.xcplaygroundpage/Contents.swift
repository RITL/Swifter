import Combine

check("Empty") {
    /// 被订阅的时候发布一个完成事件
    Empty<Int, SampleError>()
}

check("Just") {
    /// 订阅完成之前发出一个值
    Just("Hello SwiftUI")
}

check("Sequence") {
    /// 按照顺序的一串值
    //    Publishers.Sequence<[Int], Never>(sequence: [1,2,3,4])
    [1,2,3,4].publisher
}

check("Map") {
    /// 需要在publisher上调用map
    [1,2,3,4,5,6]
        .publisher
        .map { $0 * 2 }
}

check("Map Just") {
    Just(5)
        .map{$0 * 2}
}

check("Reduce") {
    [1,2,3,4,5].publisher.reduce(0, +)
}


//将中间过程保存下来
extension Sequence {
    
    public func scan<ResultElement>(
        _ initial: ResultElement,
        _ nextPartialResult: (ResultElement, Element) -> ResultElement
    ) -> [ResultElement] {
        
        var result: [ResultElement] = []
        for x in self {
            result.append(nextPartialResult(result.last ?? initial, x))
        }
        return result
    }
}

check("Scan") {
    [1,2,3,4,5].publisher.scan(0, +)
}


check("Compact Map") {
    ["1","2","3","cat","5"]
        .publisher
        .compactMap { Int($0) }
}


check("Flat Map 1") {
    [[1,2,3],["a","b","c"]]
        .publisher
        .flatMap {
            $0.publisher
    }
}


check("Flat Map 2") {
    ["A","B","C"]
        .publisher
        .flatMap { letter in
            [1,2,3]
                .publisher
                .map {
                    "\(letter)\($0)"
            }
    }
}

check("Remove Duplicated") {
    ["S", "Sw", "Sw", "Sw", "Swi",
     "Swif", "Swift", "Swift", "Swift"]
        .publisher
        .removeDuplicates()
}

check("Fail") {
    Fail<Int, SampleError>(error: .sampleError)
}


enum MyError : Error {
    case myError
}

check("Map Error") {
    Fail<Int, SampleError>(error: .sampleError)
        .mapError { _ in MyError.myError }
}

check("Throw") {
    ["1", "2", "Swift", "4"].publisher
        .tryMap { (s) -> Int in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
    }
}

check("Replace Error") {
    ["1", "2", "Swift", "4"].publisher
        .tryMap { (s) -> Int in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
    }
        .replaceError(with: -1)//返回单值
}


check("Catch with Just") {
    ["1", "2", "Swift", "4"].publisher
        .tryMap { s -> Int in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
    }
    .catch { _ in Just(-1) }
}


check("Catch with Another Publisher") {
    ["1", "2", "Swift", "4"].publisher
        .tryMap { (s) -> Int in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
    }
    .catch { _ in ["-1", "-2" , "-3"].publisher }
}


check("Catch and Continue") {
    ["1", "2", "Swift", "4"].publisher
        .flatMap { s in
            return Just(s)
                .tryMap { s in
                    guard let value = Int(s) else {
                        throw MyError.myError
                    }
                    return value
            }
            .catch { _ in Just(-1) }
    }
}


check("Container") {
    [1,2,3,4,5].publisher
    .print("[Original]")
    .contains(10)
}


check("timerPublisher") {
    [1 : "A", 2: "B", 3: "C"].timerPublisher.merge(with: [0.1: "0.1", 2.4: "2.4"].timerPublisher)
}

