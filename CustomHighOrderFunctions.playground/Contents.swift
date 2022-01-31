import Foundation
var numbers = [1, 4, 6 , 7 , 5, 2 , 10]
let marks = [[3, 4, 5], [2, 5, 3], [1, 2, 2], [5, 5, 4], [3, 5, 3]]
extension Array {
    func map2<T>(_ operation : (Element) -> T) -> [T] {
        var myArray : [T] = []
        for num in self {
            myArray.append(operation(num))
        }
        return myArray
    }
    func comPactmap2<T>(_ operation : (Element) -> T?) -> [T] {
        var myArray : [T] = []
        for num in self {
            if let some = operation(num) {
            myArray.append(some)
        }
    }
        return myArray
    }
    func filter2(_ operation : (Element) -> Bool) -> [Element] {
        var myArray : [Element] = []
        for num in self {
            if operation(num) {
                myArray.append(num)
            }
        }
        return myArray
    }
}

print(numbers.filter2{ $0 > 3 })
