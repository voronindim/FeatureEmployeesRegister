//
//  PublicItem.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

public enum PublicItem {
    public struct Folder {
        public let id: UUID
        public let name: String
    }
    
    public struct Employee {
        public let id: UUID
        public let name: String
        public let avatarUrl: URL?
    }
    
    case folders([Folder])
    case employees([Employee])
}
