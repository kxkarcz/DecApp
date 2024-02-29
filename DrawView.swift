import SwiftUI
import PencilKit


struct DrawView: View {
    var body: some View {
        Home()
            .environment(\.colorScheme, .light)
    }
}

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView()
    }
}

struct Home: View {
    @State private var showAlert = false
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var type: PKInkingTool.InkType = .pencil
    @State var isDrawViewVisible = true
    
    var body: some View {
        NavigationStack {
            DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type)
                .navigationTitle("Notes")
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.black)
                .navigationBarItems(
                    trailing: HStack(spacing: 30) {
                        Button(action: {
                            isDraw = false
                        }) {
                            Image(systemName: "eraser")
                                .font(.title)
                        }
                        Button(action: {
                            canvas.drawing = PKDrawing()
                        }) {
                            Image(systemName: "trash")
                                .font(.title)
                        }
                        Button {
                            isDraw = true
                            type = .pencil
                        } label: {
                            Image(systemName: "pencil.line")
                        }
                        Button {
                            isDraw = true
                            type = .marker
                        } label: {
                            Image(systemName: "highlighter")
                        }
                        
                        Button {
                            isDraw = true
                            type = .pen
                        } label: {
                            Image(systemName: "pencil.tip")
                        }
                        
                    }
                )
                    }
    }
    
}

struct DrawingView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isDraw: Bool
    @Binding var type: PKInkingTool.InkType
    
    var ink: PKInkingTool {
        PKInkingTool(type, color: UIColor(Color.black))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDraw ? ink : eraser
        canvas.backgroundColor = UIColor.white
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDraw ? ink : eraser
        uiView.backgroundColor = UIColor.white
    }
}
