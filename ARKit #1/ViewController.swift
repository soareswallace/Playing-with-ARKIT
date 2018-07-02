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
    let drone = Drone()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLighting()
        addDrone()
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
    
    func configureLighting(){
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    func addDrone(){
        drone.loadModel()
        sceneView.scene.rootNode.addChildNode(drone)
    }
}

extension float4x4{
    var translation: float3{
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

