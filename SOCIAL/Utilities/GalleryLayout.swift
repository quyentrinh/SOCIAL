//
//  GalleryLayout.swift
//  DefideDemo
//
//  Created by Trinh Van Quyen on 2/4/18.
//  Copyright © 2018 Trinh Van Quyen. All rights reserved.
//

import UIKit

enum ItemSize {
    case big
    case small
}

class GalleryLayout: UICollectionViewLayout {
    
    let arrLayoutType = [[ItemSize.big, ItemSize.small, ItemSize.small],
                      [ItemSize.small, ItemSize.big, ItemSize.small],
                      [ItemSize.small, ItemSize.small, ItemSize.small]]
    
    let sizeBig = UIScreen.main.bounds.width * 2 / 3
    let sizeSmall = UIScreen.main.bounds.width / 3
    let padding : CGFloat = 1.0
    
    var layoutAttributes = NSMutableDictionary()
    var contentSize = CGSize.zero
    
    override func prepare() {
        super.prepare()
        
        self.layoutAttributes.removeAllObjects()
        
        let numberOfSection  = Int((self.collectionView?.numberOfSections)!)
        
        var sectionY : CGFloat = 0.0
        
        for section in 0..<numberOfSection {
        
            let numberOfItem = Int((self.collectionView?.numberOfItems(inSection: section))!)
            let layoutTypes = arrLayoutType.randomElement()!
            let isBigLayout = self.isHaveBigItem(layout: layoutTypes)

            var offsetX : CGFloat = 0.0
            var offsetY : CGFloat = 0.0 + sectionY
            
            //layout big item first
            if isBigLayout {
                let index = self.indexOfBigItem(layout: layoutTypes)
                let indexPath = NSIndexPath(item: index, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                if index == 0 {
                    //big item display in left
                    
                    attributes.frame = CGRect(x: 0, y: offsetY, width: sizeBig + padding, height: sizeBig + padding);
                    offsetX = sizeBig + padding*2
                } else {
                    //big item display in right
                    
                    attributes.frame = CGRect(x: sizeSmall + padding, y: offsetY, width: sizeBig + padding, height: sizeBig + padding);
                }
                self.layoutAttributes.setObject(attributes, forKey: indexPath)
            }
            
            for item in 0..<numberOfItem {
                //layout all small item
                if layoutTypes[item] != .big {
                    
                    let indexPath = NSIndexPath(item: item, section: section)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                    attributes.frame = CGRect(x: offsetX, y: offsetY, width: sizeSmall, height: sizeSmall);
                    self.layoutAttributes.setObject(attributes, forKey: indexPath)
                    
                    if isBigLayout {
                        offsetY += sizeSmall + padding
                    } else {
                        offsetX += sizeSmall + padding
                    }
                }
            }
            
            sectionY += self.heighOfSection(size: layoutTypes)
            self.contentSize = CGSize(width: (self.collectionView?.frame.size.width)!, height: sectionY);
        }
        
    }
    
    func isHaveBigItem(layout: [ItemSize]) -> Bool {
        return layout.contains(.big)
    }
    
    func indexOfBigItem(layout: [ItemSize]) -> Int {
        return layout.index(of: .big)!
    }
    
    func heighOfSection(size: [ItemSize]) -> CGFloat {
        if size.contains(.big) {
            return sizeBig + padding*2
        }
        return sizeSmall + padding
    }
    
    
    // override super method
    
    override var collectionViewContentSize: CGSize
    {
        return self.contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes  in self.layoutAttributes {
            if (attributes.value as! UICollectionViewLayoutAttributes).frame.intersects(rect ) {
                layoutAttributes.append((attributes.value as! UICollectionViewLayoutAttributes))
            }
        }
        return layoutAttributes
    }
    
}


extension Array {
    func randomElement() -> Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
}
