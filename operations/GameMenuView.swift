import SwiftUI


struct GameMenuView: View {
    @State var level_completed = ["+": 0, "-": 0, "*": 0, "/": 0]
    @StateObject var textReader = TextReader()
    @ObservedObject var tasks = TaskManager.shared
    @ObservedObject var stars = Stars.shared
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
                
                VStack {
                    if stars.star<4
                    {
                        Text("\(stars.star)⭐️")
                            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                            .foregroundColor(Colors.text)
                            .font(.system(size: 40, weight: .semibold, design: .default))
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .foregroundColor(Colors.text_background)
                                    .shadow(color: .black, radius: 10)
                            )
                        Spacer()
                        HStack{
                            BackgroundTextView(text: """
                            If you want to help us, you need to collect 4 stars ⭐️.
                             One star is one fully, well-made level. 
                            In each level you have 3 examples of a given activity.
                            If you want to write out your calculations, press the pencil icon.
                            Good luck! 😁
                            """,responsive: 30)
                            .multilineTextAlignment(.center)
                            
                            ImageView(imageName: "flowers", responsiveX: 300, responsiveY: 300)
                            
                        }
                        Spacer()
                        HStack{
                            if tasks.tasks[0].completed
                            {
                                VStack{
                                    ImageView(imageName: "plusgame", responsiveX: 300, responsiveY: 300)
                                    BackgroundTextView(text: "⭐️",responsive: 100)
                                }
                            }
                            else{
                                NavigationLink(destination:GameOperationView(operation: .constant(0))){
                                    ImageView(imageName: "plusgame", responsiveX: 300, responsiveY: 300)  
                                }
                            }
                            if tasks.tasks[1].completed
                            {
                                VStack{
                                    ImageView(imageName: "minusgame", responsiveX: 300, responsiveY: 300)
                                    BackgroundTextView(text: "⭐️",responsive: 100)
                                }
                            }
                            else{
                                NavigationLink(destination:GameOperationView(operation: .constant(1))){
                                    ImageView(imageName: "minusgame", responsiveX: 300, responsiveY: 300)  
                                }
                            }
                            if tasks.tasks[2].completed
                            {
                                VStack{
                                    ImageView(imageName: "multiplicationgame", responsiveX: 300, responsiveY: 300)
                                    BackgroundTextView(text: "⭐️",responsive: 100)
                                }
                            }
                            else{
                                NavigationLink(destination:GameOperationView(operation: .constant(2))){
                                    ImageView(imageName: "multiplicationgame", responsiveX: 300, responsiveY: 300)  
                                }
                            }
                            if tasks.tasks[3].completed
                            {
                                VStack{
                                    ImageView(imageName: "divisiongame", responsiveX: 300, responsiveY: 300)
                                    BackgroundTextView(text: "⭐️",responsive: 100)
                                }
                            }
                            else{
                                NavigationLink(destination:GameOperationView(operation: .constant(3))){
                                    ImageView(imageName: "divisiongame", responsiveX: 300, responsiveY: 300) 
                                }
                            }
                        }
                        Spacer()
                        
                    }
                    else{
                        VStack{
                            Spacer()
                            BackgroundTextView(text: """
                         Thank you incredibly for your help!
                         Together we experienced a fascinating journey through the binary world 🌏. 
                         In your next binary adventures, I will be happy to accompany you as your reliable calculator 🤓.
                         Just press the calculator on the home page and press the operation you want to perform 😄
                         """,responsive: 30)
                            .multilineTextAlignment(.center)
                            HStack{
                                Button{
                                    textReader.readText("""
                         Thank you incredibly for your help!
                         Together we experienced a fascinating journey through the binary world 🌏. 
                         In your next binary adventures, I will be happy to accompany you as your reliable calculator 🤓.
                         Just press the calculator on the home page and press the operation you want to perform 😄
                         """)
                                }
                            label:{
                                Image(systemName: "speaker")
                                    .foregroundColor(Colors.text)
                                    .font(.custom("Noteworthy", size: responsiveX(40))).bold()
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .shadow(color: .black, radius: 10)
                                            .foregroundColor(Colors.text_background)
                                    )
                            }
                                Button{
                                    textReader.stopSpeaking()
                                }label:{
                                    Image(systemName: "speaker.slash")
                                        .foregroundColor(Colors.text)
                                        .font(.custom("Noteworthy", size: responsiveX(34))).bold()
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                                .shadow(color: .black, radius: 10)
                                                .foregroundColor(Colors.text_background)
                                        )
                                    
                                }    
                            }
                            Spacer()
                            NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true))
                            {
                                ButtonTextView(text: "Bye 👋", buttonColor: Colors.green_button)
                            }
                            
                            HStack{
                                ImageView(imageName: "34_1", responsiveX: 300, responsiveY: 300)
                                ImageView(imageName: "100101", responsiveX: 300, responsiveY: 300)
                                ImageView(imageName: "flowers", responsiveX: 300, responsiveY: 300)
                            }
                        }
                        
                    }
                    
                }
            }
        }
        }
    
}

struct GameMenuView_Previews: PreviewProvider{
    static var previews: some View{
        GameMenuView()
    }
}

