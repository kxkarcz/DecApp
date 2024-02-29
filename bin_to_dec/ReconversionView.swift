import SwiftUI


struct ReconversionView: View {
    @State var page_number = 0
    @StateObject var textReader = TextReader()
    @State var texts = ["""
                           Number 34 100010 thanks you very much for your help!
                           Now, on his recommendation, Number 100101 would like to
                           ask you for help in reminding me and my friends our names 🥺. 
                           ""","""
                        Cool! Before we start solving the mystery of my name 🧩, let's learn a little about converting from binary to decimal.
                        
                        In the decimal system, each digit has its own "weight," starting from the right side.
                        Similarly, in binary, we only have two digits: 0 and 1.
                        Each of these digits represents a power of 2.
                        
                        To convert a binary number to decimal, you need to understand
                        how each digit contributes to the overall value of the number.
                        Start from the right side, and for each digit,
                        multiply it by the corresponding power of 2, beginning with 2⁰.
                        Then, sum up these values to get the decimal number.
                        ""","""
                             For example, let's take the binary number 1101. Starting from the right side:
                             - 1 * 2⁰ = 1
                             - 0 * 2¹ = 0
                             - 1 * 2² = 4
                             - 1 * 2³ = 8
                             
                             Add these values: 1 + 0 + 4 + 8 = 13. You've now obtained the decimal number 13.
                             
                             Now, you're ready to try converting numbers from the binary system to decimal! Good luck! 🌟
                             
                             """]
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
                    Spacer()
                    
                    BackgroundTextView(text:texts[page_number],responsive: 30)
                        .multilineTextAlignment(.center)
                    HStack{
                        Button{
                        textReader.readText(texts[page_number])
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
                    
                    HStack {
                        ImageView(imageName: "100101", responsiveX: 400, responsiveY: 400)
                        
                        if page_number < texts.count - 1 {
                            Button(action: {
                                page_number += 1
                            }) {
                                ButtonTextView(text: "Ok!", buttonColor: Colors.green_button)
                            }
                        }
                        else if page_number == texts.count-1{
                            NavigationLink(destination: ReconversionGameView().navigationBarBackButtonHidden(true)){
                                ButtonTextView(text: "Let's go!",buttonColor: Colors.green_button)
                            }
                        }
                        
                        if page_number > 0 {
                            Button(action: {
                                page_number -= 1
                            }) {
                                ButtonTextView(text: "Back", buttonColor: Colors.back_button)
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
}

struct ReconversionView_Previews: PreviewProvider{
    static var previews: some View{
        ReconversionView()
    }
}

