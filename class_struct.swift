import SwiftUI
import AVKit

struct Tasks {
    var numbers: [[String]]
    var operation: String
    var completed: Bool
}
struct QuizItem{
    var question: String
    var answers: [String]
    var correctAnswerIndex :Int
}
struct Colors{
    static let text = Color(red: 0.15, green: 0.159, blue: 0.246)
    static let text_background = Color(red: 246/255.0, green: 224/255.0, blue: 164/255.0)
    static let back_button = Color(red:236/255.0, green:147/255.0, blue:75/255.0)
    static let green_button = Color(red: 103/255.0, green: 216/255.0, blue:103/255.0)
    static let answer_background = Color(red:243/255.0, green:244/255.0 , blue:248/255.0)
}
struct ProgressBar: View {
    var value: Double
    var total: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(value / total, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeInOut, value: value)
            
            Text("\(Int(value))/\(Int(total))")
                .font(.title)
                .foregroundColor(Color.white)
        }
    }
}

struct BackgroundTextView: View {
    var shadow = true
    var text: String
    var responsive: Int
    var body: some View {
        Text(text)
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
            .foregroundColor(Colors.text)
           .font(.custom("Futura", size: responsiveX(responsive)))
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundColor(Colors.text_background)
                    .shadow(color: .black, radius: shadow ? 10 : 0)
            )
    }
}
struct ImageView: View{
    var imageName: String
    var responsiveX: Int
    var responsiveY: Int
    var body: some View{
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: responsiveX(responsiveX), height: responsiveY(responsiveY))
    }
}

struct ButtonTextView: View{
    var text: String
    var buttonColor: Color
    var body: some View{
        Text(text)
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
            .foregroundColor(Colors.text)
            .font(.custom("Noteworthy", size: responsiveX(40))).bold()
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundColor(buttonColor)
                    .shadow(color: .black, radius: 10)
            )
    }
}


class TaskManager: ObservableObject {
    @Published var tasks: [Tasks] = [
        Tasks(numbers: [["100", "11"], ["101", "111"], ["10101", "11101"]], operation: "+", completed: false),
        Tasks(numbers: [["100", "11"], ["10111", "111"], ["1000", "1"]], operation: "-", completed: false),
        Tasks(numbers: [["10", "11"], ["11", "11"], ["100", "10"]], operation: "*", completed: false),
        Tasks(numbers: [["100", "10"], ["1000", "10"], ["1000", "100"]], operation: "/", completed: false)
    ]
    
    static let shared = TaskManager() 
    private init() {}
}
class Stars: ObservableObject{
    @Published var star = 0
    static let shared = Stars()
    private init(){}
}
extension View{
    func responsiveX(_ originalWidth: Int) -> CGFloat {
        return CGFloat(originalWidth) * (UIScreen.main.bounds.width / 1366)
    }
    
    func responsiveY(_ originalHeight: Int) -> CGFloat {
        return CGFloat(originalHeight) * (UIScreen.main.bounds.height / 1024)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

class Music{
    static let instance = Music()
    var player: AVAudioPlayer?
    enum SoundOption: String{
        case good_answer //from pixabay, licence: https://pixabay.com/pl/service/license-summary/
        case wrong_answer // from pixabay ^^
    }
    func playMusic(music: SoundOption){
        guard let url = Bundle.main.url(forResource: music.rawValue, withExtension: ".mp3") else {return}
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
        
    }
}


class TextReader: ObservableObject {
    let synthesizer = AVSpeechSynthesizer()
    
    func readText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        
        // Wybierz głos w języku angielskim, na przykład 'en-US'
        if let englishVoice = AVSpeechSynthesisVoice(language: "en-US") {
            utterance.voice = englishVoice
        }
        synthesizer.speak(utterance)
    }
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}

