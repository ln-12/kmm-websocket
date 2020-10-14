import SwiftUI
import shared

// model to observe value changes
class Model: ObservableObject {
    @Published var currentText = "Hello world"
    
    // init websocket connection
    let ws = AppSocket.init(url: "wss://echo.websocket.org")
    
}


struct ContentView: View {
    // reference to model
    @ObservedObject var model = Model()
    
    
    func initWebSocket() {
        // listen to state changes
        model.ws.stateListener = { state in
            print("New state: " + state.name)

            // if the client connected to the server, send a message
            if state == AppSocket.State.connected {
                print("Sending")
                model.ws.send(msg: "Echo")
            }
        }
        
        // listen to new messagen
        model.ws.messageListener = { message in
            print("New message: " + message)
            updateText(newText: message)
        }
    }

    // the text view in the center of the screen
    var body: some View {
        Text("\(model.currentText)").padding(8)
        Button("Connect") {
            if model.ws.currentState == AppSocket.State.closed {
                // connect to server
                print("Connecting")
                model.ws.connect()
            } else {
                print("Already connected")
            }
        }.padding(8)
        
        Button("Close") {
            // disconnect from server
            print("Disconnecting")
            model.ws.disconnect()
        }.padding(8)
    }
    
    private func updateText(newText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                self.model.currentText = newText
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
