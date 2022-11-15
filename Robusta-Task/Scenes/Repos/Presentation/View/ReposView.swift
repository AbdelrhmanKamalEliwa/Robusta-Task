//
//  ReposView.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import SwiftUI

struct ReposView: View {
    // MARK: - PROPERTIES
    //
    @StateObject var viewModel = ReposViewModel()
    @State var stateViewDidLoad: Bool = false
    
    // MARK: - BODY
    //
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.repos) { repo in
                    NavigationLink {
                        RepoCell(name: repo.name ?? "", imageURL: repo.owner?.avatarURL)
                    } label: {
                        RepoCell(name: repo.name ?? "", imageURL: repo.owner?.avatarURL)
                    } //: NavigationLink
                } //: ForEach
                
                stateView
            } //: List
            .navigationTitle("Repositories")
        } //: NavigationView
    } //: body
}

// MARK: - HELPERS
//
private extension ReposView {
    var stateView: AnyView {
        switch viewModel.state {
        case .idle:
            return Color.clear
                .onAppear {
                    if stateViewDidLoad {
                        viewModel.loadData()
                    }
                    
                    stateViewDidLoad = true
                }
                .eraseToAnyView()
            
        case .loading:
            return ProgressView()
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity, idealHeight: 40)
                .eraseToAnyView()
            
        case .loadedAll:
            return Text("All data fetched")
                .foregroundColor(.gray)
                .padding(12)
                .eraseToAnyView()
            
        case .error(let error):
            return Text(error)
                .foregroundColor(.red)
                .padding(12)
                .eraseToAnyView()
        }
    } //: stateView
}

// MARK: - PREVIEWS
//
#if DEBUG
struct ReposView_Previews: PreviewProvider {
    static var previews: some View {
        ReposView()
    }
}
#endif
