//
//  UIColor+Extensions.swift
//  ZExtensions
//
//  Created by 李文康 on 2023/11/1.
//  Copyright © 2023 FunctionMaker. All rights reserved.
//

// MARK: - Hex
extension Zonable where Base: UIColor {
    /// Init color with hex string like: prefix -> #/0x, suffix -> RGB/RGBA/RRGGBB/RRGGBBAA.
    static func color(hex: String) -> UIColor? {
        guard let rgba = _convertToRGBA(with: hex) else { return nil }
        return .init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
}

// MARK: - Private
private func _convertToRGBA(with hex: String) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
    let hexNoPrefix = hex.uppercased()
        .replacingOccurrences(of: "#", with: "")
        .replacingOccurrences(of: "0X", with: "")

    let count = hexNoPrefix.count
    guard [3, 4, 6, 8].contains(count) else { return nil }

    let red, green, blue: CGFloat?
    var alpha: CGFloat? = 1
    let stepCount: Int
    if count < 5 {
        stepCount = 1
    } else {
        stepCount = 2
    }

    let doubleSC = stepCount * 2
    let tripleSC = stepCount * 3

    red = _toCGFloat(with: hexNoPrefix[0..<stepCount])
    green = _toCGFloat(with: hexNoPrefix[stepCount..<doubleSC])
    blue = _toCGFloat(with: hexNoPrefix[doubleSC..<tripleSC])

    if count > tripleSC {
        alpha = _toCGFloat(with: hexNoPrefix[tripleSC..<stepCount * 4])
    }

    guard let red, let green, let blue, let alpha else { return nil }
    return (red, green, blue, alpha)
}

private func _toCGFloat(with hex: String) -> CGFloat? {
    guard let hexInUInt = UInt(hex, radix: 16) else { return nil }
    return CGFloat(hexInUInt) / (hex.count == 1 ? 15 : 255)
}

extension String {
    fileprivate subscript(range: Range<Int>) -> String {
        let lower = max(0, min(count, range.lowerBound))
        let upper = min(count, max(0, range.upperBound))
        let correctRange = Range(uncheckedBounds: (lower, upper))
        let start = index(startIndex, offsetBy: correctRange.lowerBound)
        let end = index(start, offsetBy: correctRange.upperBound - correctRange.lowerBound)
        return String(self[start..<end])
    }
}
