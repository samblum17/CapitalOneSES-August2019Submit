//
//  ImageCarouselView.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 8/31/22.
//  Copyright © 2022 Sam Blum. All rights reserved.
//

import SwiftUI

struct ImageCarouselView: View {
    @StateObject var imagesPassed = ImagesToPass()
    var imageURLPassed: String = ""
    var defaultImageURL = "https://www.nps.gov/common/commonspot/templates/images/logos/nps_social_image_02.jpg"
    
    var body: some View {
        if #available(iOS 15.0, *) {
        ZStack {
            Section {
                //Photo carousel section
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(imagesPassed.images, id: \.self) { photo in
                            AsyncImage(url: URL(string: photo.urlString ?? defaultImageURL)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 359, maxHeight: 192)
                                default:
                                    AsyncImage(url: URL(string: defaultImageURL)) {
                                        image in
                                        image.resizable()
                                    } placeholder: {
                                    RoundedRectangle(cornerRadius: 10)
                                    }.frame(maxWidth: 359, maxHeight: 192)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))

                                }
                            }
                        }
                    }
                }
            }
        }
        } else {

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
