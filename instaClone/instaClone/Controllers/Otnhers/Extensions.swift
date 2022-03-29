//
//  Extensions.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//


import UIKit

extension UIView {
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

extension String {
  func safeDatabaseKey() -> String {
      return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
  }
}
