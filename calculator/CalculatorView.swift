import SwiftUI

struct CalculatorView: View {
    @State var calculator = CalculatorObject()
    @State var choose_operation = ""
    @State var number1Action=""
    @State var number2Action=""
    @State var result = ""
    @State var erros : String?
    @State var number1: String = ""
    @State var number2: String = ""
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color(red: 108/255.0, green: 204/255.0, blue: 235/255.0)) 
                .ignoresSafeArea()
            VStack {
                Spacer(minLength: 100)
                HStack{
                    Spacer()
                    BackgroundTextView(text: "Number A:", responsive: 45)
                    Spacer()
                    BackgroundTextView(text: "Number B:", responsive: 45)
                    Spacer()
                }
                HStack{
                    TextField("", text: $number1)
                        . multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .placeholder(when: number1.isEmpty) {
                            Text("Number A ")
                                .foregroundColor(.gray)
                                .font(.system(size: 40, weight: .semibold, design: .default))
                                .padding()
                        }
                        .background(Colors.text_background)
                        .cornerRadius(15)
                        .font(.system(size: 40, weight: .semibold, design: .default))
                        .foregroundColor(Colors.text)
                        .padding()
                    TextField("", text: $number2)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .placeholder(when: number2.isEmpty) {
                            Text("Number B")
                                .foregroundColor(.gray)
                                .font(.system(size: 40, weight: .semibold, design: .default))
                                .padding()
                        }
                        .background(Colors.text_background)
                        .cornerRadius(15)
                        .font(.system(size: 40, weight: .semibold, design: .default))
                        .foregroundColor(Colors.text)
                        .padding()
                }
                HStack{
                    VStack{
                        BackgroundTextView(text: "Action", responsive: 40)
                        Button{
                            choose_operation = "A to decimal number"
                            switch calculator.binaryToDecimal(binaryNumber: number1) {
                            case .success(let decimalResult):
                                result = decimalResult
                            case .failure(let error):
                                result = "Error \(error)"
                            }
                        }label:{
                            BackgroundTextView(shadow: false, text: "A to decimal number", responsive: 25)
                        }
                        Button{
                            choose_operation = "A to binar number"
                            switch calculator.decimalToBinary(decimalString: number1) {
                            case .success(let success):
                                result = success
                            case .failure(let error):
                                result = "Error \(error)"
                            } 
                        }label:{
                            BackgroundTextView(shadow: false, text: "A to binar number", responsive: 25)
                        }
                    }
                    VStack{
                        BackgroundTextView(text: "Binary math operation", responsive: 35)
                        Button{
                            choose_operation="+"
                            number1Action=number1
                            number2Action=number2
                            switch calculator.performBinaryOperation(first: number1, second: number2, operation: choose_operation) {
                            case .success(let binaryResult):
                                result = " \(binaryResult)"
                            case .failure(let error):
                                result = "Error: \(error)"
                            }
                        }label:{
                            BackgroundTextView(shadow: false, text: "A + B", responsive: 25)
                        }
                        Button{
                            choose_operation="-"
                            number1Action=number1
                            number2Action=number2
                            switch calculator.performBinaryOperation(first: number1, second: number2, operation: choose_operation) {
                            case .success(let binaryResult):
                                result = " \(binaryResult)"
                            case .failure(let error):
                                result = "Error: \(error)"
                            }
                        }label:{
                            BackgroundTextView(shadow: false, text: "A - B", responsive: 25)
                        }
                        Button{
                            choose_operation="*"
                            number1Action=number1
                            number2Action=number2
                            switch calculator.performBinaryOperation(first: number1, second: number2, operation: choose_operation) {
                            case .success(let binaryResult):
                                result = " \(binaryResult)"
                            case .failure(let error):
                                result = "Error: \(error)"
                            }
                        }label:{
                            BackgroundTextView(shadow: false, text: "A * B", responsive: 25)
                        }
                        Button{
                            choose_operation = "/"
                            number1Action=number1
                            number2Action=number2
                            switch calculator.performBinaryOperation(first: number1, second: number2, operation: choose_operation) {
                            case .success(let binaryResult):
                                result = " \(binaryResult)"
                            case .failure(let error):
                                result = "Error: \(error)"
                            }
                        }label:{
                            BackgroundTextView(shadow: false, text: "A / B", responsive: 25)
                        }
                    }
                        VStack{
                            BackgroundTextView(text: "Action", responsive: 40)
                            Button{
                                choose_operation = "B to decimal number"
                                switch calculator.binaryToDecimal(binaryNumber: number1) {
                                case .success(let decimalResult):
                                    result = decimalResult
                                case .failure(let error):
                                    result = "Error \(error)"
                                }
                            }label:{
                                BackgroundTextView(shadow: false, text: "B to decimal number", responsive: 25)
                            }
                            Button{
                                choose_operation = "B to binar number"
                                switch calculator.decimalToBinary(decimalString: number2) {
                                case .success(let success):
                                    result = success
                                case .failure(let error):
                                    result = "Error \(error)"
                                } 
                            }label:{
                                BackgroundTextView(shadow: false, text: "B to binar number", responsive: 25)
                            }
                        }
                    }
                    Spacer()
                    let resultText = !["+", "-", "*", "/"].contains(choose_operation)
                    ? "Result of \(choose_operation): \(result)"
                    : "Result \(number1Action) \(choose_operation) \(number2Action) = \(result)"
                    BackgroundTextView(text: resultText, responsive: 30).bold()
                    Spacer()
            }
        }
    }
}

struct Calculator_Previews: PreviewProvider{
    static var previews: some View{
        CalculatorView()
    }
}
