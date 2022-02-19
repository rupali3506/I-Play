import Foundation
extension Array where Self == [Character] {
    func subLim(low: Int, high: Int) -> String {
        var str = ""
        for i in low...high  {
            str.append(self[i])
        }
        return str
    }
}
func checkIfPalidrome(str: String) -> Bool {
    if str.elementsEqual(str.reversed()) {
        return true
    }
    return false
}
var myString = "abaab"
var i = 0
var j = myString.count - 1
var str = Array(myString)
var temp = ""
var palArray = [String]()
for i in 0..<str.count-1 {
    for j in i+1...str.count-1 {
        temp = str.subLim(low: i, high: j)
        if temp.count > 1 {
            if  checkIfPalidrome(str: temp) {
                palArray.append(temp)
            }
        }
    }
}
print(palArray)
