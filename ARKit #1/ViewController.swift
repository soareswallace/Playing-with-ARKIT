//
//  ViewController.swift
//  ARKit #1
//
//  Created by Wallace Junior on 01/07/18.
//  Copyright © 2018 Wallace Junior. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLighting()
        addCar()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func addCar(x: Float = 0, y: Float = 0, z: Float = -0.5){
        guard let carScene = SCNScene(named: "car.dae") else {return}
        let carNode = SCNNode()
        let carSceneChildNodes = carScene.rootNode.childNodes
        
        for childNode in carSceneChildNodes{
            carNode.addChildNode(childNode)
        }
        
        carNode.position = SCNVector3(x, y, z)
        carNode.scale = SCNVector3(0.5, 0.5, 0.5)
        sceneView.scene.rootNode.addChildNode(carNode)
    }
    
    func configureLighting(){
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
}

extension float4x4{
    var translation: float3{
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

