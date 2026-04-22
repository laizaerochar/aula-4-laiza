import SwiftUI

// Extensão para cores HEX
extension Color {
    init(hex: String) {
        let hexSanitized = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

// Tela principal
struct ContentView: View {
    
    @State private var distanciaTexto: String = ""
    @State private var tempoTexto: String = ""
    @State private var velocidade: Double = 0.0
    @State private var calculoRealizado: Bool = false
    
    // Cor dinâmica
    var corDeFundoAtual: Color {
        if !calculoRealizado {
            return Color.gray.opacity(0.5)
        }
        
        switch velocidade {
        case 0..<10:
            return Color(hex: "#ABFFAC")
        case 10..<30:
            return Color(hex: "#ACFFF2")
        case 30..<70:
            return Color(hex: "#FFC5A6")
        case 70..<90:
            return Color(hex: "#EEFFA4")
        default:
            return Color(hex: "#FF7764")
        }
    }
    
    // Imagem dinâmica
    var imagemAtual: String {
        if !calculoRealizado {
            return "interrogacao_foto"
        }
        
        switch velocidade {
        case 0..<10:
            return "tartaruga_foto"
        case 10..<30:
            return "elefante_foto"
        case 30..<70:
            return "avestruz_foto"
        case 70..<90:
            return "leao_foto"
        default:
            return "guepardo_foto"
        }
    }
    
    var body: some View {
        ZStack {
            corDeFundoAtual
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Digite a distância (km):")
                    .font(.headline)
                
                TextField("0", text: $distanciaTexto)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(width: 150)
                    .multilineTextAlignment(.center)
                
                Text("Digite o tempo (h):")
                    .font(.headline)
                
                TextField("0", text: $tempoTexto)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(width: 150)
                    .multilineTextAlignment(.center)
                
                Button(action: calcularVelocidade) {
                    Text("Calcular")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: 140, height: 45)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                
                Button(action: resetar) {
                    Text("Reiniciar")
                        .foregroundColor(.white)
                        .frame(width: 140, height: 45)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
                // Resultado
                if calculoRealizado {
                    Text(String(format: "%.2f km/h", velocidade))
                        .font(.system(size: 28, weight: .bold))
                        .padding(.top, 10)
                }
                
                // Imagem
                Image(imagemAtual)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                
                Spacer()
                
                CaixaLegenda()
            }
            .padding()
        }
    }
    
    // Função de cálculo
    func resetar() {
        distanciaTexto = ""
        tempoTexto = ""
        velocidade = 0
        calculoRealizado = false
    }
    func calcularVelocidade() {
        let distFormatada = distanciaTexto.replacingOccurrences(of: ",", with: ".")
        let tempoFormatado = tempoTexto.replacingOccurrences(of: ",", with: ".")
        
        if let d = Double(distFormatada),
           let t = Double(tempoFormatado),
           t > 0 {
            
            velocidade = d / t
            calculoRealizado = true
        } else {
            velocidade = 0
            calculoRealizado = false
        }
    }
}

// Legenda
struct CaixaLegenda: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            LinhaLegenda(texto: "Tartaruga (0 - 9.9 km/h)", cor: Color(hex: "#ABFFAC"))
            LinhaLegenda(texto: "Elefante (10 - 29.9 km/h)", cor: Color(hex: "#ACFFF2"))
            LinhaLegenda(texto: "Avestruz (30 - 69.9 km/h)", cor: Color(hex: "#FFC5A6"))
            LinhaLegenda(texto: "Leão (70 - 89.9 km/h)", cor: Color(hex: "#EEFFA4"))
            LinhaLegenda(texto: "Guepardo (90+ km/h)", cor: Color(hex: "#FF7764"))
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(15)
    }
}

// Linha da legenda
struct LinhaLegenda: View {
    let texto: String
    let cor: Color
    
    var body: some View {
        HStack {
            Text(texto)
                .foregroundColor(.white)
                .font(.system(size: 12, weight: .bold))
            Spacer()
            Circle()
                .fill(cor)
                .frame(width: 15, height: 15)
        }
        .frame(width: 260)
    }
}

// Preview
#Preview {
    ContentView()
}
