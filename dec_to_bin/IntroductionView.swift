import SwiftUI

struct IntroductionView: View {
    @StateObject var textReader = TextReader()
    @State var page_number=0
    @State var texts = ["""
                             Hi! My name is 34.
                             Me and my friends have a problem because
                             We forget our surnames.
                             I think these are binary numbers.
                             Could you please help us?🥺
                             """,
                        """
                Cool! Before we start solving the mystery of my surname, let's learn a little about number systems.
                
                We use the decimal system.
                This is the one that contains the numbers 0 to 9 - { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }.
                Each of these digits in the number has its own "weight",
                that is, the place where it is located.
                
                For example, in the number 237, the digit 7 has a weight of tens and the digit 3 has a weight of hundreds. Thanks to this, we know how to understand the value of each digit.
                
                But now... what if we wanted to represent the number in a different complexion, in binary? 🤔
                """,
                        """
         In the binary system we only have two digits - 0 and 1, which is quite fascinating!
         
         Converting a number to binary is actually representing it as the sum of various powers of 2.
         It's a bit like deciphering mysterious number codes,
         but now we're opening the door to this fascinating binary world! 🚀
         """,
                        """
    1.We start with a decimal number: This is our input number that we want to convert to binary.
    2. We divide by 2: This is our first step. We record the remainder (0 or 1) as the least significant bit (LSB). We keep the entire division part aside and move on to the next step.
    3. We continue the division: Now we take the result from the previous step and divide it by 2. We again record the remainder as another bit and continue this process until we reach a result equal to 0.
    4. Invert the result: When we reach a result of 0, our remainder bits represent the binary number, but in reverse order. We need to reverse them to get the correct result.
""",
    """
    Example? Let's replace 13:
    - 13 / 2 = 6, remainder 1 (least significant bit)
    - 6 / 2 = 3, remainder 0
    - 3 / 2 = 1, remainder 1
    - 1 / 2 = 0, remainder 1 (most significant bit)
    Final score: 1101
    Now that you have mastered this simple method, we can work together to solve the mystery of my name! 🧩
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
                
                VStack {
                    Spacer()
                    BackgroundTextView(text: texts[page_number],responsive: 30)
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
                    if page_number == 1{
                        ImageView(imageName: "237", responsiveX: 400, responsiveY: 200)
                            .background(Colors.text_background)

                    }
                    Spacer()
                    HStack{
                         ImageView(imageName: "34_1", responsiveX: 500, responsiveY: 300)
                        if page_number==4 {
                            NavigationLink(destination: GameView().navigationBarBackButtonHidden(true))
                            {
                                ButtonTextView(text: "Let's go!",buttonColor: Colors.green_button)
                            }
                            
                        }
                        Button{
                            page_number+=1
                        }label:{
                            if page_number == 0{
                                ButtonTextView(text: "Yes!", buttonColor: Colors.green_button)
                            }
                            else if page_number<4{
                                ButtonTextView(text: "Ok",buttonColor: Colors.green_button)
                            }
                            Button{
                                page_number-=1
                            }label:{
                                if page_number>0{
                                    ButtonTextView(text: "No go back",buttonColor: Colors.back_button)
                                }
                            }
                        }
                    }
                    
                }
                
            }
        }
    }
}

struct IntroductionView_Previews: PreviewProvider{
    static var previews: some View{
        IntroductionView()
    }
}
