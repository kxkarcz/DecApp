import SwiftUI

struct GameOperationView: View{
    @ObservedObject var stars = Stars.shared
    @Binding var operation: Int
    @State var level = 0
    @State var won=false
    @ObservedObject var tasks = TaskManager.shared
    @State var answer=""
    @State var choosen = false
    
    var body: some View{
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color(red: 108/255.0, green: 204/255.0, blue: 235/255.0)) 
                .ignoresSafeArea()
            
            VStack {
                if won
                {
                    Spacer()
                    BackgroundTextView(text:"Congratulation 🎉 You you passed this level! ⭐️",responsive: 50)
                    Spacer()
                    NavigationLink(destination: GameMenuView().navigationBarBackButtonHidden(true))
                    {
                        ButtonTextView(text: "Next",buttonColor: Colors.green_button)
                    }
                    Spacer()
                }

                else if choosen == false
                {
                    HStack{
                        ProgressBar(value: Double(level), total: 3)
                            .frame(width: responsiveX(150), height: responsiveY(150))
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
                    Spacer()
                    BackgroundTextView(text:"\(tasks.tasks[operation].numbers[level][0]) \(tasks.tasks[operation].operation) \(tasks.tasks[operation].numbers[level][1]) is?",responsive: 90)

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
                Spacer()
                Button{
                    
                    let calculator = CalculatorObject() 
                    let result = calculator.performBinaryOperation(
                        first: tasks.tasks[operation].numbers[level][0],
                        second: tasks.tasks[operation].numbers[level][1],
                        operation: tasks.tasks[operation].operation
                    )
                    if case .success(let value) = result, Int(value) == Int(answer) {
                        if level<2{
                            level += 1
                            Music.instance.playMusic(music: .good_answer)
                        }
                        else{
                            Music.instance.playMusic(music: .good_answer)
                            tasks.tasks[operation].completed=true
                            won=true
                            stars.star+=1
                        }
                        
                    } else {
                        Music.instance.playMusic(music: .wrong_answer)
                        choosen = true
                    }
                    answer=""
                    
                    
                }label: {
                    ButtonTextView(text: "Check",buttonColor: Colors.green_button)
                }
                
                Spacer(minLength: 250)
            }else if choosen{
                Spacer()
                BackgroundTextView(text:"Wrong answer ☹️ Try again",responsive: 90)
                Spacer()
                Button{
                    choosen = false
                }label:{
                    ButtonTextView(text: "Try again", buttonColor: Colors.back_button)
                    }
                Spacer(minLength: 250)
                }
                
            }
        }
    }

}

struct GameOperationView_Previews: PreviewProvider{
    static var previews: some View{
        GameOperationView(operation: .constant(0))
    }
}
