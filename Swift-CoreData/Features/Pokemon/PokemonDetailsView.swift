//
//  PokemonDetailsView.swift
//  WorkingWithAPI-SwiftUI
//
//  Created by Glenn Ludszuweit on 24/04/2023.
//

import SwiftUI

struct PokemonDetailsView: View {
    @State var largeImageUrl: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }.padding()
            
            AsyncImage(url: URL(string: largeImageUrl)) { Image in
                Image.resizable().scaledToFit().padding().id(largeImageUrl)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView()
    }
}
