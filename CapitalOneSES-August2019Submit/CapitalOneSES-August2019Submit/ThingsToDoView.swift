//
//  ThingsToDoView.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 1/6/22.
//  Copyright © 2022 Sam Blum. All rights reserved.
//

import SwiftUI

struct ThingsToDoView: View {
    @StateObject var dataToPass = ParkDataToPass()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(dataToPass.data, id: \.self) { thing in
                    ActivityView(activity: thing)
                    Divider()
                }
                .listStyle(PlainListStyle())
            }
        }.padding([.top, .horizontal])
        
    }
}

struct ThingsToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ThingsToDoView()
    }
}

class ParkDataToPass: ObservableObject {
    @Published var abbreviation: String = ""
    @Published var data: [ThingsData] = []
}


