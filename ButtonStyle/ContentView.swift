//

import SwiftUI

struct CustomDefaultButtonStyle: PrimitiveButtonStyle {
    @State var isPressed = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.accentColor)
            .opacity(isPressed ? 0.2 : 1)
            .animation(.default, value: isPressed)
            .gesture(DragGesture(minimumDistance: 0).onChanged { value in
                var t = Transaction()
                t.disablesAnimations = true
                withTransaction(t) {
                    isPressed = true
                }
            }.onEnded({ _ in
                isPressed = false
                configuration.trigger()
            }))
    }
}

struct ContentView: View {
    @State var flag = true
    var body: some View {
        VStack {
            let b = Button(action: {
                flag.toggle()
            }, label: {
                Text("Hello, World!")
                    .padding(20)
                    .background(Color.orange)
                    .overlay {
                        Circle()
                            .frame(width: 20, height: 20)
                            .frame(maxWidth: .infinity, alignment: flag ? .leading : .trailing)
                    }
            })
            b.buttonStyle(CustomDefaultButtonStyle())
            b
            b.buttonStyle(.plain)

        }
        .font(.largeTitle)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
