//
//  RepoDetailsView.swift
//  Robusta-Task
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import SwiftUI

struct RepoDetailsView: View {
    // MARK: - PROPERTIES
    //
    @StateObject var viewModel: RepoDetailsViewModel
    
    // MARK: - INIT
    //
    init(viewModel: RepoDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    
    // MARK: - BODY
    //
    var body: some View {
        VStack(alignment: .center, spacing: 60) {
            ImageLoadingView(url: viewModel.repo.owner?.avatarURL, imageSize: 200)
                .clipShape(Circle())
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.gray, lineWidth: 4)
                ) //: overlay
                .shadow(radius: 10)
            
            VStack(alignment: .leading, spacing: 24) {
                drawInfo(
                    labelName: "Name",
                    labelValue: viewModel.repo.name ?? "Not Found"
                ) //: drawInfo
                
                drawInfo(
                    labelName: "Full Name",
                    labelValue: viewModel.repo.fullName ?? "Not Found"
                ) //: drawInfo
                
                drawInfo(
                    labelName: "Is Private",
                    labelValue: "\(viewModel.repo.isPrivate ?? true)"
                ) //: drawInfo
                
                drawInfo(
                    labelName: "Repository ID",
                    labelValue: "\(viewModel.repo.id ?? -1)"
                ) //: drawInfo
            } //: VStack
            
            
            Spacer()
        } //: VStack
        .padding(24)
    } //: body
}

// MARK: - HELPERS
//
private extension RepoDetailsView {
    func drawInfo(labelName: String, labelValue: String) -> some View {
        HStack(spacing: 16) {
            Text(labelName)
                
            Text(labelValue)
                .bold()
        } //: HStack
    } //: drawInfo
}

// MARK: - PREVIEWS
//
#if DEBUG
struct RepoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepoDetailsView(viewModel: .init(repo: .init(id: 4, name: "Repository", fullName: "Repository", isPrivate: nil, owner: nil)))
    }
}
#endif
