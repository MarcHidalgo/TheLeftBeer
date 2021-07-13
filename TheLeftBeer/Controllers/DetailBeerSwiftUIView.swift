//
//  DetailBeerSwiftUIView.swift
//  TheLeftBeer
//
//  Created by Marc Hidalgo on 10/7/21.
//

import SwiftUI

struct DetailBeerSwiftUIView: View {
        
    let beer: Beer
    let image:UIImage?
    
    init(beer: Beer, image:UIImage?) {
        self.beer = beer
        self.image = image
       
    }
    
    var body: some View {

        VStack {
            
            ScrollView(.vertical, showsIndicators: true){
                
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.top, 10)
                    
                }else{
                    Image(uiImage: UIImage(named: "Beer")!)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                VStack(alignment: .center, spacing: 1) {
                    
                    HStack (alignment: .center, spacing: 1, content: {
                        Text("IBU:")
                            .font(.system(size: 21))
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                            .padding()
                          
                        if let ibu = self.beer.ibu {
                            Text(String(format: "%.0f", ibu))
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                        }
                    })

                    Text("Ingredients:")
                        .font(.system(size: 21))
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                        .padding()
                    
                    ForEach(1..<4) { row in
                        switch row {
                            
                        case 1:
                            
                            VStack {
                                
                                Text("Malt:")
                                    .font(.system(size: 21))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .frame( maxWidth: .infinity, alignment: .center)
                                    .padding()
                                
                                if let malt = beer.ingredients.malt.count {
                                    
                                    ForEach(0..<malt) { row in
                                        
                                        Text("\(beer.ingredients.malt[row].name):  \(String(format:  "%.2f",beer.ingredients.malt[row].amount.value))  \(beer.ingredients.malt[row].amount.unit.rawValue)")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.gray)
                                            .frame( maxWidth: .infinity, alignment: .center)
                                            .padding()
                                    }
                                }
                            }
                            
                        case 2:
                            VStack {
                                
                                Text("Hops:")
                                    .font(.system(size: 21))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .frame( maxWidth: .infinity, alignment: .center)
                                    .padding()
                                
                                if let hops = beer.ingredients.hops.count {
                                    
                                    ForEach(0..<hops) { row in
                                        
                                        Text("\(beer.ingredients.hops[row].name):  \(String(format:  "%.2f",beer.ingredients.hops[row].amount.value))  \(beer.ingredients.hops[row].amount.unit.rawValue)")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.gray)
                                            .frame( maxWidth: .infinity, alignment: .center)
                                            .padding()
                                    }
                                }
                            }

                        case 3:
            
                            VStack {
                                
                                Text("Yeast:")
                                    .font(.system(size: 21))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .frame( maxWidth: .infinity, alignment: .center)
                                    .padding()
                                        
                                Text("\(beer.ingredients.yeast)")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    .frame( maxWidth: .infinity, alignment: .center)
                                    .padding()
                            }
                            
                        default:
                            
                            Text("")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .frame( maxWidth: .infinity, alignment: .center)
                                .padding()
                        }
                    }
                    
                    Text("Food Pairing:")
                        .font(.system(size: 21))
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                        .padding()
                 
                    ForEach(beer.foodPairing, id: \.self) { s in
                        Text(s)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .frame( maxWidth: .infinity, alignment: .center)
                            .padding()
                    }
                    
                }.padding(.bottom,10)
            }
            .navigationBarTitle(Text(beer.name)).navigationBarHidden(false)
            
        }.background(Color(.systemGray6))
        .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
      
    }
}

