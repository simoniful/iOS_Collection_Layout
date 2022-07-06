//
//  MySection.swift
//  Playground
//
//  Created by Sang hun Lee on 2022/07/06.
//

import Foundation

enum MySection {
    struct MainItem {
        let text: String
    }
    struct SubItem {
        let text: String
    }
    
    case main([MainItem])
    case sub([SubItem])
}
