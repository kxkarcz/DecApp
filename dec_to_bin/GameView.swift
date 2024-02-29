import SwiftUI

struct GameView: View {
    @State var elapsedTime: TimeInterval = 0
    @State var timer: Timer? = nil
    @State var finishTime = ""
    @State var finish = false
    @State var my_name = false
    @State var isOn = false
    @State var answer = ""
    @State var questionNumber=0
    @State var choosen = false
    @State var stars = 0
    @State var help = false
    @State var quizArray: [QuizItem] = [
        QuizItem(question: "2 in binary is?", answers: ["00","01","10","11"], correctAnswerIndex: 2),
        QuizItem(question: "16 in binary is?", answers: ["10000","01110","11011","1101"], correctAnswerIndex: 0),
        QuizItem(question: "20 in binay is?", answers: ["10111","11100","10101", "10100"], correctAnswerIndex: 3),
        QuizItem(question: "12 in binary is?", answers: ["1100","1111","1010","1000"], correctAnswerIndex: 0),
        QuizItem(question: "That's time for me! You Have only one chance! 🤯 34 in binary is?", answers:["100010"], correctAnswerIndex:0)
    ]
    var body: some View {
        NavigationStack{
            ZStack{
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color(red: 108/255.0, green: 204/255.0, blue: 235/255.0)) 
                    .ignoresSafeArea()
                VStack{
                    if isOn == false{
                        Spacer()
                        ImageView(imageName: "34_1", responsiveX: 500, responsiveY: 300)
                        BackgroundTextView(text:"Decimal to Binary conversion Quiz",responsive: 40).bold()
                        BackgroundTextView(text:"""
                        This quiz was created to help me and my friends remember
                        our last name. Please fill them out correctly to help us 🤓
                        In order for each of us to remember his name, you need to earn 5 stars ⭐️.
                        1 star = 1 good answer.
                        If you want to write out your calculations, press the pencil icon
                        Good Luck! 🚀
                        """,responsive: 30)
                        .multilineTextAlignment(.center)
                        Spacer()
                        Button{
                            isOn = true
                            startTimer()
                        }label:{
                            ButtonTextView(text: "Start",buttonColor: Colors.green_button)
                        }
                        Spacer(minLength: 100)
                    }
                    else{
                        
                        VStack{

                            if finish {
                                Spacer()
                                if Int(answer) == Int(quizArray[questionNumber].answers[quizArray[questionNumber].correctAnswerIndex]) {
                                    BackgroundTextView(text: "Yes, my surname is 100010!\nCongratulation! 🎉 You collect \(stars+1) / 5 ⭐️ in \(finishTime)", responsive: 50)
                                } else {
                                    BackgroundTextView(text: "No, my surname is 100010\nCongratulation! 🎉 You collect \(stars) / 5 ⭐️ in \(finishTime)", responsive: 50)
                                    
                                }
       
                                Spacer()
                                Button{
                                    finish=false
                                    isOn=false
                                    stars=0
                                    questionNumber=0
                                    answer=""
                                }
                                label:{
                                    ButtonTextView(text: "Try again", buttonColor: Colors.back_button)
                                }
                                Spacer()
                                NavigationLink(destination: ReconversionView().navigationBarBackButtonHidden(true)){
                                    ButtonTextView(text: "Next",buttonColor: Colors.green_button)
                                }
                                Spacer()
  
                            }
                            else{
                                HStack{
                                    HStack{
                                        Text("⏳ \(timeString(time: elapsedTime))")
                                        Spacer()
                                        ProgressBar(value: Double(questionNumber), total: Double(quizArray.count))
                                    }
                                    .frame(width: responsiveX(300), height: responsiveY(150))
                                    .padding()
                                    .font(.custom("Futura", size: responsiveX(30)))
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
                                BackgroundTextView(text:"\(stars) ⭐️ / \(questionNumber)",responsive: 30)
                                Spacer()
                                if (questionNumber<quizArray.count-1 && choosen==false ){
                                    BackgroundTextView(text:quizArray[questionNumber].question, responsive: 35).bold()
                                    ForEach(0..<quizArray[questionNumber].answers.count, id: \.self) { index in
                                        Button
                                        {
                                            if(quizArray[questionNumber].correctAnswerIndex==index) {
                                                Music.instance.playMusic(music: .good_answer)
                                                stars+=1
                                                questionNumber+=1
                                            }
                                            else
                                            {
                                                Music.instance.playMusic(music: .wrong_answer)
                                                choosen=true
                                            }
                                        }
                                    label:{
                                        Text("\(quizArray[questionNumber].answers[index])")
                                            .font(.system(size: 40, weight: .semibold, design: .default))
                                            .padding()
                                            .foregroundColor(Colors.text)
                                            .background(Colors.answer_background)
                                            .cornerRadius(15)
                                    }
                                    }
                                    Spacer()
                                }else if choosen==true{
                                    BackgroundTextView(text: "Wrong answer 🙁 Try think again 😉", responsive: 40)
                                    if help==false{
                                        Button{
                                            choosen=false
                                        }label:{
                                            ButtonTextView(text:"Try again",buttonColor: Colors.back_button)
                                        }
                                    }
                                    else{
                                        Button{
                                            choosen=false
                                            questionNumber+=1
                                            help=false
                                        }label:{
                                            ButtonTextView(text:"Next",buttonColor: Colors.green_button)
                                        }
                                    }
                                    Button{
                                        help = true
                                    }label: {
                                        ButtonTextView(text:"Answer",buttonColor: Colors.back_button)
                                    }
                                    if help{
                                        BackgroundTextView(text:"Answer: \(quizArray[questionNumber].answers[quizArray[questionNumber].correctAnswerIndex])",responsive:40)
                                        
                                    }
                                    Spacer()
                                }
                                else if (questionNumber == quizArray.count-1 && choosen == false)
                                {
                                    ImageView(imageName: "34_1", responsiveX: 250, responsiveY: 250)
                                    BackgroundTextView(text:quizArray[questionNumber].question,responsive: 40)
                                    Spacer()
                                    TextField("", text: $answer)
                                        .keyboardType(.numberPad)
                                        .placeholder(when:answer.isEmpty) {
                                            Text("Answer: ")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 40, weight: .semibold, design: .default))
                                                .padding()
                                        }
                                        .background(Colors.text_background)
                                        .cornerRadius(15)
                                        .font(.system(size: 40, weight: .semibold, design: .default))
                                        .frame(width: responsiveX(300), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(Colors.text)
                                        .padding()
                                    Button{
                                        finish=true
                                        finishTime = timeString(time: elapsedTime)
                                        stopTimer()

                                         if Int(answer) == Int(quizArray[questionNumber].answers[quizArray[questionNumber].correctAnswerIndex])
                                        {
                                             Music.instance.playMusic(music: .good_answer)
                                         }
                                        else{
                                            Music.instance.playMusic(music: .wrong_answer)
                                        }
                                    
                                        
                                    }label:
                                    {
                                        ButtonTextView(text:"Next",buttonColor: Colors.green_button)
                                    }
                                    Spacer(minLength: 200)
                                }
                            }
                        }
                    }
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

struct GameView_Previews: PreviewProvider{
    static var previews: some View{
        GameView()
    }
}
