import SwiftUI

struct ContentView: View {
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
                    ImageView(imageName: "logo_wieksze", responsiveX: 500, responsiveY: 200)
                Spacer()
                Image("DecApp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(25)
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                    NavigationLink{
                        IntroductionView()

                    }label: {
                        ButtonTextView(text: "Start",buttonColor: Colors.green_button)
                    }
                    Spacer()
                    NavigationLink{
                        CalculatorView()
                        
                    }label:{
                        ButtonTextView(text: "Calculator",buttonColor: Colors.green_button)
                    }  
                    Spacer()

                }
            }
        }
    }
}





