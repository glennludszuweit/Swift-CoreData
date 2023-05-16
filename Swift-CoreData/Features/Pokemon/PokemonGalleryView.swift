//
//  PokemonListView.swift
//  WorkingWithAPI-SwiftUI
//
//  Created by Glenn Ludszuweit on 24/04/2023.
//

import SwiftUI
import CoreData

struct PokemonGalleryView: View {
    @StateObject var pokemonViewModel: PokemonViewModel
    @State private var showDetails: Bool = false
    @State private var hasError: Bool = false
    @State var largeImage: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
    @FetchRequest(entity: PokemonEntity.entity(), sortDescriptors: [])
    var result: FetchedResults<PokemonEntity>
    
    func getApiData() async {
        print(result)
        await pokemonViewModel.getAll(context: viewContext)
        if pokemonViewModel.customError != nil {
            hasError = true
        }
    }
    
    @ViewBuilder
    func displayAlert() -> some View {
        ProgressView().alert(isPresented: $hasError) {
            Alert(title: Text("Something went wrong!"), message: Text((pokemonViewModel.customError?.errorDescription)!))
        }
    }
    
    var body: some View {
        if pokemonViewModel.customError != nil {
            displayAlert()
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(result) { item in
                        AsyncImage(url: URL(string: item.images!.small!)) {
                            phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .onTapGesture {
                                        showDetails = true
                                        largeImage = item.images!.large!
                                    }
                                    .sheet(isPresented: $showDetails) {
                                        PokemonDetailsView(largeImageUrl: largeImage)
                                    }
                                    .id(item.id)
                            } else if phase.error != nil {
                                Text(ErrorHandler.imageDoesNotExist.errorDescription!)
                            } else {
                                ProgressView()
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .task {
                    await getApiData()
                    guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {return}
                    
                    let sqlitePath = url.appendingPathComponent("Pokemon_CoreData.sqlite")
                    print(sqlitePath)
                }.refreshable {
                    await getApiData()
                }
            }
        }
    }
}


struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGalleryView(pokemonViewModel: PokemonViewModel(networkManager: NetworkManager()))
    }
}
