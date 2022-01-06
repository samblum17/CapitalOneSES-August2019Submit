//
//  ThingsToDoView.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 1/6/22.
//  Copyright © 2022 Sam Blum. All rights reserved.
//

import SwiftUI

struct ThingsToDoView: View {
    @StateObject var test = ParkDataToPass()
    
    var body: some View {
        Text((test.data.first?.longDescription?.replacingOccurrences(of: "<[^>]+>", with: "\n", options: .regularExpression, range: nil)) ?? "here")
            .onTapGesture{
                let query: [String: String] = [
                    "parkCode" : "yose",
                    "api_key" : "0deJt7XudkZrb2wSMFjaLYrHQESBWIQHMNeuM7o1"
                ]
                let controller = StoreThingsToDoController()
                controller.fetchItems(matching: query, completion: { (returnedData) in
                    test.data = returnedData!
            })
    }
}
}

struct ThingsToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ThingsToDoView()
    }
}

class ParkDataToPass: ObservableObject {
    @Published var data: [ThingsData] = []
}
