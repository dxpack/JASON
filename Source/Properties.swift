//
// Properties.swift
//
// Copyright (c) 2015-2016 Damien (http://delba.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

// MARK: - NULL

extension JSON {
    /// True if the value is not present
    public var null: Bool { return _storedObject == nil }
}

// MARK: - JSON

extension JSON {
    /// The value as JSON
    public var json: JSON { return self }
}

// MARK: - String

extension JSON {
    /// The value as a string or nil if not present/convertible
    public var string: String? { return _storedObject as? String }
}

// MARK: - Integer

extension JSON {
    /// The value as a signed integer or nil if not present/convertible
    public var int: Int? {
        if let i = _storedObject as? Int    { return i }
        if let u = _storedObject as? UInt   { return u <= UInt(Int.max)   ? Int(u) : nil }
        if let i = _storedObject as? Int64  { return i <= Int64(Int.max)  ? Int(i) : nil }
        if let u = _storedObject as? UInt64 { return u <= UInt64(Int.max) ? Int(u) : nil }
        if let i = _storedObject as? Int8   { return Int(i) }
        if let i = _storedObject as? Int16  { return Int(i) }
        if let i = _storedObject as? Int32  { return Int(i) }
        if let u = _storedObject as? UInt8  { return Int(u) }
        if let u = _storedObject as? UInt16 { return Int(u) }
        if let u = _storedObject as? UInt32 { return u <= UInt32(Int32.max) ? Int(u) : nil }
        return nil
    }
    /// The value as a 64-bit signed integer or nil if not present/convertible
    public var int64: Int64? {
        if let i = _storedObject as? Int64  { return i }
        if let i = _storedObject as? Int    { return Int64(i) }
        if let u = _storedObject as? UInt   { return UInt64(u) <= UInt64(Int64.max) ? Int64(u) : nil }
        if let u = _storedObject as? UInt64 { return u <= UInt64(Int64.max) ? Int64(u) : nil }
        if let i = _storedObject as? Int8   { return Int64(i) }
        if let i = _storedObject as? Int16  { return Int64(i) }
        if let i = _storedObject as? Int32  { return Int64(i) }
        if let u = _storedObject as? UInt8  { return Int64(u) }
        if let u = _storedObject as? UInt16 { return Int64(u) }
        if let u = _storedObject as? UInt32 { return Int64(u) }
        return nil
    }
    /// The value as an 8-bit signed integer or nil if not present/convertible
    public var int8: Int8? {
        if let i = _storedObject as? Int8 { return i }
        if let i = int, i >= Int(Int8.min) && i <= Int(Int8.max) { return Int8(i) }
        return nil
    }
    /// The value as a 16-bit signed integer or nil if not present/convertible
    public var int16: Int16? {
        if let i = _storedObject as? Int16 { return i }
        if let i = int, i >= Int(Int16.min) && i <= Int(Int16.max) { return Int16(i) }
        return nil
    }
    /// The value as a 32-bit signed integer or nil if not present/convertible
    public var int32: Int32? {
        if let i = _storedObject as? Int32 { return i }
        if let i = int, i >= Int(Int32.min) && i <= Int(Int32.max) { return Int32(i) }
        return nil
    }
}

// MARK: - Unsigned Integer

extension JSON {
    /// The value as an unsigned integer or nil if not present/convertible
    public var uInt: UInt? {
        if let u = _storedObject as? UInt   { return u }
        if let i = _storedObject as? Int    { return i >= 0 ? UInt(i) : nil }
        if let i = _storedObject as? Int64  { return i >= 0 && UInt64(i) <= UInt64(UInt.max) ? UInt(i) : nil }
        if let u = _storedObject as? UInt64 { return u <= UInt64(UInt.max) ? UInt(u) : nil }
        if let i = _storedObject as? Int8   { return i >= 0 ? UInt(i) : nil }
        if let i = _storedObject as? Int16  { return i >= 0 ? UInt(i) : nil }
        if let i = _storedObject as? Int32  { return i >= 0 ? UInt(i) : nil }
        if let u = _storedObject as? UInt8  { return UInt(u) }
        if let u = _storedObject as? UInt16 { return UInt(u) }
        if let u = _storedObject as? UInt32 { return UInt(u) }
        return nil
    }
    /// The value as a 64-bit signed integer or nil if not present/convertible
    public var uInt64: UInt64? {
        if let u = _storedObject as? UInt64 { return u }
        if let i = _storedObject as? Int    { return i >= 0 ? UInt64(i) : nil }
        if let u = _storedObject as? UInt   { return UInt64(u) }
        if let i = _storedObject as? Int64  { return i >= 0 ? UInt64(i) : nil }
        if let i = _storedObject as? Int8   { return i >= 0 ? UInt64(i) : nil }
        if let i = _storedObject as? Int16  { return i >= 0 ? UInt64(i) : nil }
        if let i = _storedObject as? Int32  { return i >= 0 ? UInt64(i) : nil }
        if let u = _storedObject as? UInt8  { return UInt64(u) }
        if let u = _storedObject as? UInt16 { return UInt64(u) }
        if let u = _storedObject as? UInt32 { return UInt64(u) }
        return nil
    }
    /// The value as an 8-bit signed integer or nil if not present/convertible
    public var uInt8: UInt8? {
        if let u = _storedObject as? UInt8 { return u }
        if let u = uInt, u <= UInt(UInt8.max) { return UInt8(u) }
        return nil
    }
    /// The value as a 16-bit signed integer or nil if not present/convertible
    public var uInt16: UInt16? {
        if let u = _storedObject as? UInt16 { return u }
        if let u = uInt, u <= UInt(UInt16.max) { return UInt16(u) }
        return nil
    }
    /// The value as a 32-bit signed integer or nil if not present/convertible
    public var uInt32: UInt32? {
        if let u = _storedObject as? UInt32 { return u }
        if let u = uInt, u <= UInt(UInt32.max) { return UInt32(u) }
        return nil
    }
}

// MARK: - FloatingPointType

extension JSON {
    /// The value as a 64-bit floating-point number or nil if not present/convertible
    public var double: Double? {
        if let d = _storedObject as? Double { return d }
        if let f = _storedObject as? Float  { return Double(f) }
        if let i = _storedObject as? Int64  { return Double(i) }
        if let u = _storedObject as? UInt64 { return Double(u) }
        return nil
    }
    /// The value as a 32-bit floating-point number or nil if not present/convertible
    public var float: Float? {
        if let f = _storedObject as? Float  { return f }
        if let d = _storedObject as? Double { return Float(d) }
        if let i = _storedObject as? Int64  { return Float(i) }
        if let u = _storedObject as? UInt64 { return Float(u) }
        return nil
    }
}

// MARK: - Bool

extension JSON {
    /// The value as a boolean or nil if not present/convertible
    public var bool: Bool? { return _storedObject as? Bool }
}

// MARK: - NSDate

extension JSON {
    /// The value as a NSDate or nil if not present/convertible
    public var date: Date? { return string == nil ? nil : JSON.dateFormatter.date(from: string!) }
}

// MARK: - NSURL

extension JSON {
    /// The value as an instance of NSURL or nil if not convertible
    public var url: URL? {
        if let string = string?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return URL(string: string)
        }
        return nil
    }
}

// MARK: - Dictionary

extension JSON {
    /// The value as a dictionary or nil if not present/convertible
    public var swiftDictionary: [String: Any]? { return _storedObject as? [String: Any] }
    /// The value as a dictionary (NSDictionary) or nil if not present/convertible
    internal var nsDictionary: NSDictionary? { return _storedObject as? NSDictionary }
    /// The value as a JSON dictionary or nil if not present/convertible
    public var object: [String: JSON]? { return swiftDictionary?.reduceValues{ JSON($0) }}
}

// MARK: - Array

extension JSON {
    /// The value as an array or nil if not present/convertible
    public var swiftArray: [Any]? { return _storedObject as? [Any] }
    /// The value as an array (NSArray) or nil if not present/convertible
    internal var nsArray: NSArray? { return _storedObject as? NSArray }
    /// The value as a JSON array or nil if not present/convertible
    public var array: [JSON]? { return swiftArray?.map{ JSON($0) } }
}
