//
//  TotalText.swift
//  First Project
//
//  Created by Nilootpal Das on 13/12/22.
//

import SwiftUI

struct TotalText: View {
    var value: String = "0"
    var body: some View {
        Text(value)
            .padding()
            .font(.system(size: 60))
            .foregroundColor(.white)
            .lineLimit(1)
    }
}

struct TotalText_Previews: PreviewProvider {
    static var previews: some View {
        TotalText()
            .background(.black)
    }
}
