
import Foundation

func address(o: UnsafePointer<Void>) -> Int {
    return unsafeBitCast(o, to: Int.self)
}
struct MemoryAddress<T>: CustomStringConvertible {
let intValue: Int
var description: String {
let length = 2 + 2 * MemoryLayout<UnsafeRawPointer>.size
return String(format: "%0\(length)p", intValue)
    }
// for structures
    init(of structPointer: UnsafePointer<T>) {
        intValue = Int(bitPattern: structPointer)
    }
}
extension MemoryAddress where T: AnyObject {
// for classes
    init(of classInstance: T) {
        intValue = unsafeBitCast(classInstance, to: Int.self)
// or      Int(bitPattern: Unmanaged<T>.passUnretained(classInstance).toOpaque())
    }
}
final class MyClass {
    var myVar: String
    var myVar2: Int
    
    init(_ myVar: String, _ myVar2: Int) {
        self.myVar = myVar
        self.myVar2 = myVar2
    }
}
struct MyStruct {
    var myRef : MyClass
    init(obj: MyClass) {
        self.myRef = MyClass(obj.myVar, obj.myVar2)
    }
}
extension MyStruct {
    var myAnotherObj : MyClass {
        get { myRef }
        set {
            if !isKnownUniquelyReferenced(&myRef) {
                myRef = MyClass(newValue.myVar,newValue.myVar2)
            return
        }
            self.myAnotherObj = myRef
        }
    }
    var name : String {
        get { myRef.myVar }
        set {
            if !isKnownUniquelyReferenced(&myRef) {
            myRef = MyClass(newValue, myRef.myVar2)
            return
        }
            myRef.myVar = newValue
        }
    }
    var id : Int {
        get { myRef.myVar2 }
        set {
            if !isKnownUniquelyReferenced(&myRef) {
                myRef = MyClass(myRef.myVar, newValue)
            return
        }
            myRef.myVar2 = newValue
        }
    }
}

var obj1 = MyStruct(obj: MyClass("Rupali", 1234))
var obj2 = obj1
let structInstanceAddress1 = MemoryAddress(of: &obj1)
print(String(format: "%018p", structInstanceAddress1.intValue))
let structInstanceAddress2 = MemoryAddress(of: &obj2)
print(String(format: "%018p", structInstanceAddress2.intValue))




