//
//  DetailBeerSwiftUIView.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import SwiftUI

struct DetailBeerSwiftUIView: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "Beer")!)
                .resizable()
                .scaledToFit()
            
           
            Text("Beer")
                .font(.title)
                .bold()
                .padding(.top, 20)
        }
        .padding(.top, 15).padding(.bottom, 50)
    }
}

struct DetailBeerSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailBeerSwiftUIView()
    }
}
