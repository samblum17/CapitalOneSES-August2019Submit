//
//  ActivityView.swift
//  CapitalOneSES-August2019Submit
//
//  Created by Sam Blum on 1/6/22.
//  Copyright © 2022 Sam Blum. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    var activity: ThingsData
    
    var body: some View {
        let customBrown = Color(UIColor(red: (0.725/1.0), green: (0.380/1.0), blue: (0.122/1.0), alpha: 1.0))
        
        VStack (alignment: .leading) {
            if #available(iOS 14.0, *) {
                Text(activity.title ?? "")
                    .foregroundColor(customBrown)
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                Text(activity.shortDescription ?? "")
                    .padding(.bottom)
                HStack {
                    Text("Reservation Required: ")
                    Text(activity.isReservationRequired == "false" ? "No" : "Yes")
                }
                HStack {
                    Text("Price: ")
                    Text(activity.doFeesApply == "false" ? "Free" : "Fees apply")
                }
            } else {
                Text(activity.title ?? "")
                    .foregroundColor(customBrown)
                    .bold()
                    .padding(.bottom)
                Text(activity.shortDescription ?? "")
                    .padding(.bottom)
                HStack {
                    Text("Reservation Required: ")
                    Text(activity.isReservationRequired == "false" ? "No" : "Yes")
                }
                HStack {
                    Text("Price: ")
                    Text(activity.doFeesApply == "false" ? "Free" : "Fees apply")
                }
            }
        }
    }
}

