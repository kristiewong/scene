//
//  sceneFeed.swift
//  Scene
//
//  Created by Kristie Wong on 11/30/17.
//  Copyright © 2017 Kristie Wong. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

var scenes: [String: UIImage] = ["Campanile": #imageLiteral(resourceName: "campanile"), "Botanical Garden": #imageLiteral(resourceName: "garden"), "Sunshine Wall": #imageLiteral(resourceName: "sunshine")]

var sceneNames = ["Campanile", "Botanical Garden", "Sunshine Wall"]
var sceneImages: [UIImage] = [#imageLiteral(resourceName: "campanile"),#imageLiteral(resourceName: "sunshine"),#imageLiteral(resourceName: "garden")]
