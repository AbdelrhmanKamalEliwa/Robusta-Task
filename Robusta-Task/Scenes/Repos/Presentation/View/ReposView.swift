//
//  ReposView.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import SwiftUI

struct ReposView: View {
    @StateObject var viewModel = ReposViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        RepoCell(name: item.name ?? "", imageURL: item.owner?.avatarURL)
                    } label: {
                        RepoCell(name: item.name ?? "", imageURL: item.owner?.avatarURL)
                    }
                }
                
                switch viewModel.state {
                case .idle:
                    Color.clear
                        .onAppear {
                            viewModel.loadMore()
                        }
                    
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity, idealHeight: 40)
                    
                case .loadedAll:
                    Text("All data fetched")
                        .foregroundColor(.gray)
                        .padding(12)
                    
                case .error(let error):
                    Text(error)
                        .foregroundColor(.red)
                        .padding(12)
                }
            }
            .navigationTitle("Repositories")
            
        }
    }
}

struct ReposView_Previews: PreviewProvider {
    static var previews: some View {
        ReposView()
    }
}
