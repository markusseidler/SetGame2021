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
        if rowCount == 0 || columnCount == 0 {
            return CGSize.zero
        } else {
            let proposedWidth = geoSize.width / CGFloat(columnCount)
            let proposedHeight = geoSize.height / CGFloat(rowCount)
            
//            let geoAspectRatio = geoSize.width / geoSize.height
            
            var desiredWidth: CGFloat
            var desiredHeight: CGFloat
            
            if proposedWidth <= proposedHeight * globalAspectRatio {
                desiredWidth = proposedWidth
                desiredHeight = proposedWidth / globalAspectRatio
            } else {
                desiredWidth = proposedHeight * globalAspectRatio
                desiredHeight = proposedHeight
            }
            
//            return CGSize(width: geoSize.width / CGFloat(columnCount), height: geoSize.height / CGFloat(rowCount))
            return CGSize(width: desiredWidth, height: desiredHeight)
        }
    }
    
    var geoSizeAspectRatio: Double {
        Double(geoSize.width / geoSize.height)
    }
    
    func location(at index: Int) -> CGPoint {
        if rowCount == 0 || columnCount == 0 {
            return CGPoint.zero
        } else {
            return CGPoint(
                x: (CGFloat(index % columnCount) + 0.5) * itemSize.width,
                y: (CGFloat(index / columnCount) + 0.5) * itemSize.height)
        }
    }
    
    private var itemCount: Int
    private var geoSize: CGSize
    private var globalAspectRatio: CGFloat
    
    private(set) var rowCount: Int = 0
    private(set) var columnCount: Int = 0

    mutating private func getRowAndColumnCount() {
        guard geoSize.width != 0, geoSize.height != 0, itemCount > 0 else { return }
        
        var smallestVariance: Double?
        var bestLayout: (rowCount: Int, columnCount: Int) = (1, itemCount)
        
        for rows in 1...itemCount {
            let columns = (itemCount / rows) + (itemCount % rows > 0 ? 1 : 0)
            
            if (rows - 1) * columns < itemCount {
                let itemAspectRatio = geoSizeAspectRatio * (Double(rows) / Double(columns))
                let variance = abs(itemAspectRatio - geoSizeAspectRatio)
                
                if smallestVariance == nil || variance < smallestVariance! {
                    smallestVariance = variance
                    bestLayout = (rowCount: rows, columnCount: columns)
                }
            }
        }
        
        rowCount = bestLayout.rowCount
        columnCount = bestLayout.columnCount
        
    }
    
    
}
