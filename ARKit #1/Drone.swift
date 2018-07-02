//
//  Drone.swift
//  ARKit #1
//
//  Created by Wallace Junior on 02/07/18.
//  Copyright © 2018 Wallace Junior. All rights reserved.
//

import Foundation
import ARKit

class Drone: SCNNode{
    func loadModel(){
        guard let virtualObjectScene = SCNScene(named:"Drone_dae.dae") else {return}
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes{
            wrapperNode.addChildNode(child)
        }
        addChildNode(wrapperNode)
    }
}
