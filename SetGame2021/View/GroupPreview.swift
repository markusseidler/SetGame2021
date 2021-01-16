//
//  GroupPreview.swift
//  SetGame2021
//
//  Created by Markus Seidler on 16/1/21.
//

import Foundation

import SwiftUI

//https://stackoverflow.com/questions/56938805/how-to-pass-one-swiftui-view-as-a-variable-to-another-view-struct

struct GroupPreview<Content: View>: View {
    
    init(@ViewBuilder baseView: @escaping () -> Content) {
        self.baseView = baseView()
    }
    
    private var baseView: Content
    private var arrayOfDevices: [Devices] = [.twelveProMax, .twelvePro, .eight, .se, .iPadProTwelveNine]
    
    var body: some View {
        Group {
            
            ForEach(arrayOfDevices, id: \.self) { device in
                getPotraitView(of: device)
                getLandscapeView(of: device)
            }
        }

    }
    
    private func getPotraitView(of device: Devices) -> some View {
        return baseView
            .previewDevice(PreviewDevice(rawValue: device.rawValue))
            .previewDisplayName(device.rawValue)
    }
    
    private func getLandscapeView(of device: Devices) -> some View {
        return baseView
            .previewDevice(PreviewDevice(rawValue: device.rawValue))
            .previewDisplayName(device.rawValue)
            .previewLayout(PreviewLayout.fixed(width: device.getLandScapeDimension().width, height: device.getLandScapeDimension().height))
    }
    
    
}


//            // 12 Pro Max Portrait
//            baseView
//                .previewDevice(PreviewDevice(rawValue: Devices.twelveProMax.rawValue))
//                .previewDisplayName(Devices.twelveProMax.rawValue)
//
//            // 12 Pro Max Landscape
//            baseView
//                .previewDevice(PreviewDevice(rawValue: Devices.twelveProMax.rawValue))
//                .previewDisplayName(Devices.twelveProMax.rawValue)
//                .previewLayout(PreviewLayout.fixed(width: Devices.twelveProMax.getLandScapeDimension().width, height: Devices.twelveProMax.getLandScapeDimension().height))
//
//            // 12 Pro Portrait
//            baseView
//                .previewDevice(PreviewDevice(rawValue: Devices.twelvePro.rawValue))
//                .previewDisplayName(Devices.twelvePro.rawValue)
//
//            // 12 Pro Landscape
//            baseView
//                .previewDevice(PreviewDevice(rawValue: Devices.twelvePro.rawValue))
//                .previewDisplayName(Devices.twelvePro.rawValue)
//                .previewLayout(PreviewLayout.fixed(width: Devices.twelvePro.getLandScapeDimension().width, height: Devices.twelvePro.getLandScapeDimension().height))
//
//            // 8 Portrait
//            baseView
//                .previewDevice(PreviewDevice(rawValue: Devices.eight.rawValue))
//                .previewDisplayName(Devices.eight.rawValue)
//
//            // 8 Landscape
//            baseView
//                .previewDevice(PreviewDevice(rawValue: Devices.eight.rawValue))
//                .previewDisplayName(Devices.eight.rawValue)
//                .previewLayout(PreviewLayout.fixed(width: Devices.eight.getLandScapeDimension().width, height: Devices.eight.getLandScapeDimension().height))
//
//            // SE Portrait
//            baseView
//                .previewDevice(PreviewDevice(rawValue: Devices.se.rawValue))
//                .previewDisplayName(Devices.se.rawValue)
//
//            // SE Landscape
//            baseView
//                .previewDevice(PreviewDevice(rawValue: Devices.se.rawValue))
//                .previewDisplayName(Devices.se.rawValue)
//                .previewLayout(PreviewLayout.fixed(width: Devices.se.getLandScapeDimension().width, height: Devices.se.getLandScapeDimension().height))
//
//            // iPad Pro 12.9 Portrait`
//            baseView
//                .previewDevice(PreviewDevice(rawValue: Devices.iPadProTwelveNine.rawValue))
//                .previewDisplayName(Devices.iPadProTwelveNine.rawValue)
//
//            // iPad Pro 12.9  Landscape
//            baseView
//                .previewDevice(PreviewDevice(rawValue: Devices.iPadProTwelveNine.rawValue))
//                .previewDisplayName(Devices.iPadProTwelveNine.rawValue)
//                .previewLayout(PreviewLayout.fixed(width: Devices.iPadProTwelveNine.getLandScapeDimension().width, height: Devices.iPadProTwelveNine.getLandScapeDimension().height))
//        }
