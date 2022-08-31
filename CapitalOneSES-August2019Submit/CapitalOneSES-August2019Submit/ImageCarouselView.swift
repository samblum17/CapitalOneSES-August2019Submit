//
//  ImageCarouselView.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 8/31/22.
//  Copyright © 2022 Sam Blum. All rights reserved.
//

import SwiftUI
import CachedAsyncImage

struct ImageCarouselView: View {
    @StateObject var imagesPassed = ImagesToPass()
    
    var body: some View {
        ZStack {
            Section {
                //Photo carousel section
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(imagesPassed.images, id: \.url) { photo in
                            CachedAsyncImage(url: URL(string: photo)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 300, maxHeight: 200)
                                default:
                                    AsyncImage(url: URL(string: "https://www.nps.gov/common/commonspot/templates/images/logos/nps_social_image_02.jpg")) {
                                        image in
                                        image.resizable()

                                    }.frame(maxWidth: 200, maxHeight: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
      
                                }
                            }
                        }
                    }
                }
            }.padding([.leading, .bottom])
        }
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCarouselView()
    }
}


class ImagesToPass: ObservableObject {
    @Published var images: [Images] = []
}
