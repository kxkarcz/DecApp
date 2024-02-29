import SwiftUI

struct MathOperationsView: View {
    @StateObject var textReader = TextReader()
    @State var pageNumber = 0
    @State var image = false
    @State var examples = ["dodawanie","odejmowanie","mnozenie","dzielenie"]
     @State var texts = ["""
Good job! Now we flowers need your help 🌸. 
In order for us to continue growing, 
you need to perform some mathematical operations on us and our friends.
""","""
Before we get started, let's learn a little about mathematical operations with binary numbers

In the binary system, addition is pretty easy.
Just like in the decimal system, you add the digits 
from right to left, carrying over any "extra" to the next column.

Let's take an example:
""","""
Great! Time to unravel the mysteries of binary subtraction!

Similar to addition, binary subtraction involves working from right to left. 
When subtracting, if the digit in the column on the right is smaller than 
the one you're subtracting, you need to borrow from the next column on the left.

Let's try an example:
""","""
Let's explore the world of binary multiplication.

Just like in the decimal system, binary multiplication 
involves multiplying each digit and then summing up the results.

Let's take an example:
""", """
Ready for the next challenge? Let's venture into the realm of binary division.
Binary division is similar to decimal division, involving successive subtraction and shifting.
Let's take an example:
"""
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
                       if pageNumber == 0{
                        Spacer()
                           BackgroundTextView(text:texts[pageNumber],responsive: 32)
                               .multilineTextAlignment(.center)
                           HStack{
                               Button{
                                   textReader.readText(texts[pageNumber])
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
                        HStack{
                             ImageView(imageName: "flowers", responsiveX: 500, responsiveY: 500)
                            Button{
                                pageNumber+=1
                            }label:{
                                ButtonTextView(text: "Let's go!",buttonColor: Colors.green_button)
                            }
                        }
                    }
                    
                    else if image == false{
                        Spacer()
                        BackgroundTextView(text:texts[pageNumber],responsive: 32)
                        HStack{
                            Button{
                                textReader.readText(texts[pageNumber])
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
                        HStack{
                           ImageView(imageName: "flowers", responsiveX: 500, responsiveY: 500)
                            Button{
                                image=true
                            }label:{
                                ButtonTextView(text: "Next",buttonColor: Colors.green_button)
                            }
                            Button{
                                pageNumber-=1
                                if pageNumber>1{
                                    image=true
                                }
                            }label:{
                                ButtonTextView(text: "Back", buttonColor: Colors.back_button)
                            }
                        }
                    }
                    else if image{
                        Spacer()
                            Image(examples[pageNumber-1])
                                 .resizable()
                                 .scaledToFit()
                                 .background(Colors.text_background)
                                .cornerRadius(25)
                                .shadow(color: .black, radius: 10)
                        Spacer()
                        HStack{
                            ImageView(imageName: "flowers", responsiveX: 500, responsiveY: 500)
                            if pageNumber==texts.count-1{
                                NavigationLink(destination: GameMenuView().navigationBarBackButtonHidden(true)){
                                    ButtonTextView(text: "Next",buttonColor: Colors.green_button)
                                }
                            }
                            else{
                                Button{
                                    pageNumber+=1
                                    image=false
                                }label:{
                                    ButtonTextView(text: "Next",buttonColor: Colors.green_button)
                                }
                            }
                                Button{
                                    image=false
                                }label:{
                                    ButtonTextView(text: "Back",buttonColor: Colors.back_button)
                                }
                            }
                        }
                    
                    
                    
                }
                
            }
        }
    }
}
            

struct MathOperationsView_Previews: PreviewProvider{
    static var previews: some View{
        MathOperationsView()
    }
}
