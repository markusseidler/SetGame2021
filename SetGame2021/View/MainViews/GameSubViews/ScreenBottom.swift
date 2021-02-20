////
////  ScreenBottom.swift
////  SetGame2021
////
////  Created by Markus Seidler on 19/2/21.
////
//
//import SwiftUI
//
//struct ScreenBottom: View {
//    
//    @Binding var cardDeckPosition: CGRect
//    let cardSize: CGSize
//   
//    
//    var body: some View {
//    
//        CardDeck(cardDeckPosition: cardDeckPosition, cardSize: cardSize)
//        
//        VStack(
//        
//        // build screenbottom here and then finish new Gameview..
//        // including all the function.
//        
////        CardDeck(cardDeckPosition: <#T##Binding<CGRect>#>, cardSize: <#T##Binding<CGSize>#>)
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct ScreenBottom_Previews: PreviewProvider {
//    static var previews: some View {
//        ScreenBottom()
//    }
//}
//
////private func createLowerScreen(size: CGSize) -> some View {
////    return HStack {
////        cardDeck
////        VStack {
////            Button {
////                if game.isFaceUpViewCards.count > 0 {
////                    dealMoreCards()
////                } else {
////                    startDealing()
////                }
////            } label: {
////                Text("Deal")
////            }
////            .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: 1.0))
////            .accessibility(identifier: AccessID.firstDealButton)
////            Button {
////                withAnimation(Animation.easeInOut(duration: 1.0)) {
////                    cheat()
////                }
////
////            } label: {
////                Text("Cheat")
////            }
////            .buttonStyle(PrimaryButtonStyle(geometrySize: size, opacityLevel: 1.0, color: Color.rainbowOrange))
////
////        }
////    }
////}
