import SwiftUI

class CalculatorObject: ObservableObject {
    enum ConversionError: Error {
        case invalidBinaryInput
        case negativeDecimalInput
        case divisionByZero
    }
    
    func binaryToDecimal(binaryNumber: String) -> Result<String, ConversionError> {
        var decimalNumber = 0
        var exponent = 0
        
        for digit in binaryNumber.reversed() {
            guard let digitValue = Int(String(digit)), digitValue == 0 || digitValue == 1 else {
                return .failure(.invalidBinaryInput)
            }
            decimalNumber += digitValue * Int(pow(2, Double(exponent)))
            exponent += 1
        }
        
        return .success(String(decimalNumber))
    }
    
    func decimalToBinary(decimalString: String) -> Result<String, ConversionError> {
        guard let decimalNumber = Int(decimalString), decimalNumber >= 0 else {
            return .failure(.negativeDecimalInput)
        }
        
        var binaryNumber = ""
        var decimalCopy = decimalNumber
        
        while decimalCopy > 0 {
            let remainder = decimalCopy % 2
            binaryNumber += String(remainder)
            decimalCopy /= 2
        }
        if decimalNumber == 0 {
            return .success("0")
        }
        else{
            return .success(String(binaryNumber.reversed()))
        }
    }
    
    
    func performBinaryOperation(first: String, second: String, operation: String) -> Result<String, ConversionError> {
        guard let firstDecimal = try? binaryToDecimal(binaryNumber: first).get(),
              let secondDecimal = try? binaryToDecimal(binaryNumber: second).get() else {
            return .failure(.invalidBinaryInput)
        }
        
        guard let firstInt = Int(firstDecimal), let secondInt = Int(secondDecimal) else {
            return .failure(.invalidBinaryInput)
        }
        
        var result: Int = 0
        var remainder: Int = 0
        
        switch operation {
        case "+":
            result = firstInt + secondInt
        case "-":
            result = firstInt - secondInt
        case "*":
            result = firstInt * secondInt
        case "/":
            guard secondInt != 0 else {
                return .failure(.divisionByZero)
            }
            result = firstInt / secondInt
            remainder = firstInt % secondInt
            
        default:
            return .failure(.invalidBinaryInput)
        }
        
        if operation == "/" {
            if remainder == 0 {
                return decimalToBinary(decimalString: String(result))
            } else {
                let resultString = "\(result), remainder: \(remainder)"
                return .success(resultString)
            }
        } else {
            return decimalToBinary(decimalString: String(result))
        }
    }
    
}


