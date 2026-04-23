import SwiftUI

struct ContentView: View {
    @State private var mostrarAlerta = false
    
    var body: some View {
        ZStack {
            Image("Image 1")
                .resizable()
                .scaledToFill()
                .blur(radius: 4)
                .ignoresSafeArea()
            
            VStack {
                Text("Bem vindo, Fulano")
                    .font(.title)
                    .padding(.top, 60)
                
                Spacer()
                
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                Spacer()
                
                Button("Entrar") {
                    mostrarAlerta = true
                }
                .padding(.bottom, 30)
                .alert("ALERTA !", isPresented: $mostrarAlerta) {
                    Button("Vamos lá!") {
                        print("Continuar...")
                    }
                } message: {
                    Text("Você irá iniciar o desafio da aula agora")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
