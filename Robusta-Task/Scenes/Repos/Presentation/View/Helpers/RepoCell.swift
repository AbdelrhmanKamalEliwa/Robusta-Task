//
//  RepoCell.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 14/11/2022.
//

import SwiftUI

struct RepoCell: View {
    // MARK: - PROPERTIES
    //
    private var name: String
    private var imageURL: String?
    
    // MARK: - INIT
    //
    init(
        name: String,
        imageURL: String?
    ) {
        self.name = name
        self.imageURL = imageURL
    }
    
    // MARK: - BODY
    //
    var body: some View {
        HStack(spacing: 24) {
            ImageLoadingView(url: imageURL)
                .clipShape(Circle())
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 4)
                ) //: overlay
                .shadow(radius: 10)
            
            Text(name)
        } //: HStack
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
    } //: body
}
