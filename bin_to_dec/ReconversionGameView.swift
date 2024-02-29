import SwiftUI

struct ReconversionGameView: View {
    @State var elapsedTime: TimeInterval = 0
    @State var timer: Timer? = nil
    @State var loss = false
    @State var won = false
    @State var isOn = false
    @State var finishTime = ""
    @State var quizArray: [String] = ["01","1001","100101","10101","110","1010111"]
    @State var questionNumber = 0
    @State var answer = ""
    @State var calculator = CalculatorObject()
    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color(red: 108/255.0, green: 204/255.0, blue: 235/255.0))
                    .ignoresSafeArea()
                VStack {
                    if isOn == false && loss == false {
                        ImageView(imageName: "100101", responsiveX: 400, responsiveY: 400)
                        BackgroundTextView(text:"Binary to decimal - fight for survival",responsive: 40).bold()
                        BackgroundTextView(text: """
                        This game was created to remind me and my friends of our names. 
                        Answer the questions correctly to move on to the next one.
                        When you answer incorrectly, the game will end. 
                        If you want to write out your calculations, press the pencil icon
                        Try to have the best time possible! Good luck! 💪
                        """,responsive: 30)
                        .multilineTextAlignment(.center)
                        Spacer()
                        Button {
                            isOn = true
                            startTimer()
                        } label: {
                            ButtonTextView(text: "Start",buttonColor: Colors.green_button)
                        }
                        Spacer()
                    } else if isOn && loss == false && won == false && questionNumber < quizArray.count {
                        HStack{
                            HStack{
                                Text("⏳ \(timeString(time: elapsedTime))")
                                ProgressBar(value: Double(questionNumber), total: Double(quizArray.count))
                                    .frame(width: responsiveX(150), height: responsiveY(150))
                                    .padding()
 
                                
                            }
                            .font(.custom("Futura", size: responsiveX(40)))
                            .foregroundColor(Colors.text)
                            .padding()
                            .background(Colors.text_background)
                            .cornerRadius(25)
                            NavigationLink(destination: DrawView()){
                                Image(systemName: "pencil")
                                    .font(.custom("Futura", size: responsiveX(40)))
                                    .foregroundColor(Colors.text)
                                    .padding()
                                    .background(Colors.text_background)
                                    .cornerRadius(25)
                            
      
                            }
                        }
                        Spacer()
                        BackgroundTextView(text:"Change from binary to decimal: \(quizArray[questionNumber])",responsive:40)
                        Spacer()
                        TextField("", text: $answer)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .placeholder(when: answer.isEmpty) {
                                Text("Answer")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 40, weight: .semibold, design: .default))
                                    .padding()
                            }
                            .background(Colors.text_background)
                            .cornerRadius(15)
                            .font(.system(size: 40, weight: .semibold, design: .default))
                            .foregroundColor(Colors.text)
                            .frame(width: responsiveX(400), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding()
                        if questionNumber == quizArray.count-1 {
                            Button {
                                finishTime = timeString(time: elapsedTime)
                                stopTimer()
                                if let unwrappedResult = try? calculator.binaryToDecimal(binaryNumber: quizArray[questionNumber]).get(), Int(answer) == Int(unwrappedResult) {
                                    won = true
                                    Music.instance.playMusic(music: .good_answer)
                                } else {
                                    loss = true
                                    Music.instance.playMusic(music: .wrong_answer)
                                }
                            } label: {
                                ButtonTextView(text: "Check",buttonColor: Colors.green_button)
                            }
                        } else {
                            Button {
                                if let unwrappedResult = try? calculator.binaryToDecimal(binaryNumber: quizArray[questionNumber]).get(), Int(answer) == Int(unwrappedResult) {
                                    questionNumber += 1
                                    answer = ""
                                    Music.instance.playMusic(music: .good_answer)
                                } else {
                                    loss = true
                                    finishTime = timeString(time: elapsedTime)
                                    stopTimer()
                                    Music.instance.playMusic(music: .wrong_answer)
                                }
                            } label: {
                                ButtonTextView(text: "Check",buttonColor: Colors.green_button)
                            }
                        }
                    } else if loss {
                        Spacer()
                        BackgroundTextView(text:"You lost 😞 You answer \(questionNumber) / \(quizArray.count) in \(finishTime)",responsive: 40)
                        HStack {
                            NavigationLink(destination:
                                            MathOperationsView().navigationBarBackButtonHidden(true)) {
                                ButtonTextView(text: "Next",buttonColor: Colors.green_button)
                            }
                            Button {
                                loss = false
                                stopTimer()
                                isOn = false
                                questionNumber = 0
                                answer = ""
                            } label: {
                                ButtonTextView(text: "Try again",buttonColor: Colors.back_button)
                            }
                        }
                    } else if won {
                        Spacer()
                        BackgroundTextView(text:"You won! You answer \(questionNumber + 1) / \(quizArray.count) in \(finishTime) 🎉",responsive: 40)
                        HStack{
                            NavigationLink(destination: MathOperationsView().navigationBarBackButtonHidden(true)) {
                                ButtonTextView(text: "Next",buttonColor: Colors.green_button)
                            }
                            Button {
                                loss = false
                                won=false
                                stopTimer()
                                isOn = false
                                questionNumber = 0
                                answer = ""
                            } label: {
                                ButtonTextView(text: "Try again",buttonColor: Colors.back_button)
                            }
                        }
                    }
                    Spacer(minLength: 50)
                }
                
            }
        }
    
    }
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            elapsedTime += 1
        }
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        elapsedTime = 0
    }
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ReconversionGameView_Previews: PreviewProvider {
    static var previews: some View {
        ReconversionGameView()
    }
}

