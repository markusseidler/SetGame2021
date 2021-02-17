//
//  GridLayout.swift
//  SetGame2021
//
//  Created by Markus Seidler on 30/1/21.
//

import SwiftUI

// TODO: Add animation of flying from deck
// TODO: Add flipping cards from deck to playfield

struct GridConstructor {
    
    init(itemCount: Int, geoSize: CGSize, globalAspectRatio: CGFloat) {
    
        self.itemCount = itemCount
        self.geoSize = geoSize
        self.globalAspectRatio = globalAspectRatio
        
        getRowAndColumnCount()
        
    }
    
    var itemSize: CGSize {
        getItemSize(columns: columnCount, rows: rowCount)
        
//        if rowCount == 0 || columnCount == 0 {
//            return CGSize.zero
//        } else {
//            let proposedWidth = geoSize.width / CGFloat(columnCount)
//            let proposedHeight = geoSize.height / CGFloat(rowCount)
//
////            let geoAspectRatio = geoSize.width / geoSize.height
//
//            var desiredWidth: CGFloat
//            var desiredHeight: CGFloat
//
//            if proposedWidth <= proposedHeight * globalAspectRatio {
//                desiredWidth = proposedWidth
//                desiredHeight = proposedWidth / globalAspectRatio
//            } else {
//                desiredWidth = proposedHeight * globalAspectRatio
//                desiredHeight = proposedHeight
//            }
//
////            return CGSize(width: geoSize.width / CGFloat(columnCount), height: geoSize.height / CGFloat(rowCount))
//            return CGSize(width: desiredWidth, height: desiredHeight)
//        }
    }
    
    var geoSizeAspectRatio: Double {
        Double(geoSize.width / geoSize.height)
    }
    
    func location(at index: Int) -> CGPoint {
        if rowCount == 0 || columnCount == 0 {
            return CGPoint.zero
        } else {
            return CGPoint(
                x: (CGFloat(index % columnCount) + 0.8) * itemSize.width + widthOffset,
                y: (CGFloat(index / columnCount) + 0.6) * itemSize.height)
        }
    }
    
    private var itemCount: Int
    private var geoSize: CGSize
    private var globalAspectRatio: CGFloat
    private var widthOffset: CGFloat {
        (geoSize.width - (CGFloat(columnCount) + 0.8 ) * itemSize.width) / 2
    }
    
    private(set) var rowCount: Int = 0
    private(set) var columnCount: Int = 0

    mutating private func getRowAndColumnCount() {
        guard geoSize.width != 0, geoSize.height != 0, itemCount > 0 else { return }
        
        var smallestVariance: Double?
        var bestLayout: (rowCount: Int, columnCount: Int) = (1, itemCount)
        
        for columns in 1...itemCount {
            let rows = (itemCount / columns) + (itemCount % columns > 0 ? 1 : 0)
          
            if (columns - 1) * rows < itemCount {
                let proposedItemSize = getItemSize(columns: columns, rows: rows)
                let geoArea = Double(geoSize.width * geoSize.height)
                let itemArea = Double(proposedItemSize.width * proposedItemSize.height) * Double(itemCount)
                let unUsedAreaRatio = (1 - itemArea / geoArea)
                
                if smallestVariance == nil || unUsedAreaRatio < smallestVariance! {
                    smallestVariance = unUsedAreaRatio
                    bestLayout = (rowCount: rows, columnCount: columns)
                }
            }
        }
        
        rowCount = bestLayout.rowCount
        columnCount = bestLayout.columnCount
        
    }
    
    private func getItemSize(columns: Int, rows: Int) -> CGSize {
        if columns == 0 || rows == 0 {
            return CGSize.zero
        } else {
            let proposedWidth = geoSize.width / CGFloat(columns)
            let proposedHeight = geoSize.height / CGFloat(rows)
            
            var desiredWidth: CGFloat
            var desiredHeight: CGFloat
            
            if proposedWidth <= proposedHeight * globalAspectRatio {
                desiredWidth = proposedWidth
                desiredHeight = proposedWidth / globalAspectRatio
            } else {
                desiredWidth = proposedHeight * globalAspectRatio
                desiredHeight = proposedHeight
            }
            
            return CGSize(width: desiredWidth, height: desiredHeight)
            
        }
        
    }
    
}
