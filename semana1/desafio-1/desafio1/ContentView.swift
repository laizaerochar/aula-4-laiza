//
//  ContentView.swift
//  desafio1
//
//  Created by Turma01-11 on 17/04/26, laiza
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                //vermelho cima
                    .fill(.red)
                    .frame(width:100, height:100)
                Spacer()
                    .padding()
                
                Rectangle()
                //azul cima
                    .fill(.blue)
                    .frame(width:100, height:100)
            }
                Spacer()
            HStack {
                Rectangle()
                    .fill(.green)
                    .frame(width:100, height:100)
                Spacer()
                
                Rectangle()
                //amarelo baixo
                    .fill(.yellow)
                    .frame(width:100, height:100)
            }
            .padding()
            
        }
    }
}

#Preview {
    ContentView()
}
