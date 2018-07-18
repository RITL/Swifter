import Foundation

public struct RegexHelper {
    let regex: NSRegularExpression
    
    public init(_ pattern: String) throws {//初始化自己的属性
        try regex = NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    public func match(_ input: String) -> Bool {//进行匹配
        let matches = regex.matches(in: input, options: [], range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
}
