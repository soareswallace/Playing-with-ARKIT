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
        addBox()
        addTapGestureToSceneView()
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
    
    func addBox(x: Float = 0, y: Float = 0, z: Float = -0.2){
        let box = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius:0)
        //we are setting the box size -> 1.0 float is 1meter
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(x, y, z) //stay on center with a little proximity to the camera
        //a rot node in a scnee that defines the coordinate system of the real world rendered by SceneKit
        
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer){
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else{
            let hitTestResultWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            
            if let hitTestResultWithFeaturePoints = hitTestResultWithFeaturePoints.first{
                let translation = hitTestResultWithFeaturePoints.worldTransform.translation
                addBox(x: translation.x, y: translation.y, z: translation.z)
            }
            return
        }
        node.removeFromParentNode()
    }
    
    func addTapGestureToSceneView(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension float4x4{
    var translation: float3{
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

