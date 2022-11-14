//
//  ImageLoadingView.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 14/11/2022.
//

import SwiftUI

struct ImageLoadingView: View {
    // MARK: - PROPERTIES
    //
    @StateObject var imageLoader: ImageLoader
    var imageSize: CGFloat = 40
    
    // MARK: - INIT
    //
    init(url: String?) {
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    // MARK: - BODY
    //
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
            } else if imageLoader.errorMessage != nil {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
            } else {
                ProgressView()
                    .frame(width: imageSize, height: imageSize)
            } //: Condition
        } //: Group
        .onAppear {
            imageLoader.fetch()
        } //: onAppear
    } //: body
}

// MARK: - PREVIEWS
//
#if DEBUG
struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(url: "")
    }
}
#endif
