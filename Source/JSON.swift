//
// JSON.swift
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

// MARK: - Initializers

public struct JSON {
    /// The date formatter used for date conversions
    public static var dateFormatter = DateFormatter()
    
    /// The object on which any subsequent method operates
    internal var _storedObject: Any?

    /**
     Creates an instance of JSON initialized to contain nil.
     
     - returns: the created JSON
     */
    public init() {}

    /**
        Creates an instance of JSON from AnyObject.

        - parameter object: An instance of any class

        - returns: the created JSON
    */
    public init(_ object: Any?) {
        self.init(object: object)
    }

    /**
        Creates an instance of JSON from NSData.

        - parameter data: An instance of NSData

        - returns: the created JSON
    */
    public init(_ data: Data?) {
        self.init(object: JSON.objectWithData(data))
    }
    
    /**
        Creates an instance of JSON from a string.

        - parameter data: A string

        - returns: the created JSON
    */
    public init(_ string: String?) {
        self.init(string?.data(using: String.Encoding.utf8))
    }

    /**
        Creates an instance of JSON from AnyObject.
        Takes an explicit parameter name to prevent calls to init(_:) with NSData? when nil is passed.

        - parameter object: An instance of any class

        - returns: the created JSON
    */
    internal init(object: Any?) {
        self._storedObject = object
    }
}

// MARK: - Subscript

extension JSON {
    /**
        Creates a new instance of JSON.

        - parameter index: A string

        - returns: a new instance of JSON or itself if its object is nil.
    */
    public subscript(index: String) -> JSON {
        get {
            if _storedObject == nil { return self }

            if let nsDictionary = nsDictionary {
                return JSON(nsDictionary[index])
            }

            return JSON(object: nil)
        }
        set {
            if let value = newValue._storedObject {
                if _storedObject == nil {
                    _storedObject = NSDictionary(dictionary: [index: value])
                    //                } else if let d = swiftDictionary {
                    //                    var d = d
                    //                    d[index] = value
                    //                    _storedObject = d
                } else if let d = nsDictionary {
                    let d = NSMutableDictionary(dictionary: d)
                    d[index] = value
                    _storedObject = d
                }
            }
        }
    }

    /**
        Creates a new instance of JSON.

        - parameter index: A string

        - returns: a new instance of JSON or itself if its object is nil.
    */
    public subscript(index: Int) -> JSON {
        get {
            if _storedObject == nil { return self }

            if let nsArray = nsArray {
                return JSON(nsArray[safe: index])
            }

            return JSON(object: nil)
        }
        set {
            if let value = newValue._storedObject {
                if _storedObject == nil {
                    _storedObject = NSArray(array: [value])
                    //                } else if let a = swiftArray {
                    //                    var a = a
                    //                    a[index] = value
                    //                    _storedObject = a
                } else if let a = nsArray {
                    let a = NSMutableArray(array: a)
                    a[index] = value
                    _storedObject = a
                }
            }
        }
    }
    
    /**
        Creates a new instance of JSON.
        
        - parameter indexes: Any
        
        - returns: a new instance of JSON or itself if its object is nil
     */
    public subscript(path indexes: Any...) -> JSON {
        return self[indexes]
    }
    
    internal subscript(indexes: [Any]) -> JSON {
        if _storedObject == nil { return self }
        
        var json = self
        
        for index in indexes {
            if let string = index as? String, let object = json.nsDictionary?[string] {
                json = JSON(object)
                continue
            }
            
            if let int = index as? Int, let object = json.nsArray?[safe: int] {
                json = JSON(object)
                continue
            }
            
            else {
                json = JSON(object: nil)
                break
            }
        }
        
        return json
    }
}

// MARK: - Deserialize
extension JSON {
    
    public func deserialize(nestLevel: Int = 0, _ withFormatting: Bool = true) -> String {
        
        var nestLevel = nestLevel
        
        var linefeed = ""
        var tab = ""
        var space = ""
        
        if withFormatting {
            linefeed = "\n"
            tab = "\t"
            space = " "
        }
        
        if let o = nsDictionary {
            
            var jsonString = "{\(linefeed)"
            
            nestLevel += 1
            var nestString = ""
            if withFormatting {
                for _ in 0..<nestLevel {
                    nestString += "\(tab)"
                }
            }
            
            o.forEach({ (k, v) in
                jsonString += "\(nestString)\"\(k)\":\(space)\(JSON(v).deserialize(nestLevel: nestLevel, withFormatting)),\(linefeed)"
            })
            
            if o.allKeys.count > 0 {
                jsonString.remove(at: jsonString.index(before: jsonString.endIndex))
            }
            
            if withFormatting {
                
                if o.allKeys.count > 0 {
                    jsonString.remove(at: jsonString.index(before: jsonString.endIndex))
                }
                
                jsonString += "\(linefeed)"
                
                for _ in 0..<nestLevel - 1 {
                    jsonString += "\(tab)"
                }
            }
            
            jsonString += "}"
            
            return jsonString
            
        } else if let a = nsArray {
            
            var jsonString = "["
            
            nestLevel += 1
            var nestString = ""
            if withFormatting {
                for _ in 0..<nestLevel {
                    nestString += "\(tab)"
                }
            }
            
            a.forEach({ v in
                jsonString += "\(linefeed)\(nestString)\(JSON(v).deserialize(nestLevel: nestLevel, withFormatting)),"
            })
            
            if a.count > 0 {
                jsonString.remove(at: jsonString.index(before: jsonString.endIndex))
            }
            
            if withFormatting {
                jsonString += "\(linefeed)"
                
                for _ in 0..<nestLevel - 1 {
                    jsonString += "\(tab)"
                }
            }
            
            jsonString += "]"
            
            return jsonString
            
        } else if let s = string {
            
            return "\"\(s)\""
            
        } else if let d = double, fmod(d, 1) != 0 || d < Double(Int64.min) || d > Double(UInt64.max - 1024) {
            
            return "\(d)".lowercased()
            
        } else if let i = int {
            
            return "\(i)"
            
        } else if let i = int64 {
            
            return "\(i)"
            
        } else if let u = uInt64 {
            
            return "\(u)"
            
        } else if let b = bool {
            
            return "\(b)".lowercased()
            
        } else {
            
            return "null"
            
        }
    }
}

// MARK: - Private extensions

private extension JSON {
    /**
        Converts an instance of Data to Any.

        - parameter data: An instance of Data or nil

        - returns: An instance of Any or nil
    */
    static func objectWithData(_ data: Data?) -> Any? {
        guard let data = data else { return nil }

        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    }
}

