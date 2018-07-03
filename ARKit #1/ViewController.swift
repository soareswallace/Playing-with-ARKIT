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
    let kMovingLengthPerLoop: CGFloat = 0.05
    let kRotationRadianPerLoop: CGFloat = 0.2
    
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
    
    @IBAction func upLongPressed(_ sender: UILongPressGestureRecognizer) {
        let action = SCNAction.moveBy(x: 0, y: kMovingLengthPerLoop, z: 0, duration: 0.1)
        execute(action: action, sender: sender)
    }
    
    @IBAction func downLongPressed(_ sender: UILongPressGestureRecognizer) {
        let action = SCNAction.moveBy(x: 0, y: -kMovingLengthPerLoop, z: 0, duration: 0.1)
        execute(action: action, sender: sender)
    }
    
    @IBAction func moveRightLongPRessed(_ sender: UILongPressGestureRecognizer) {
        let x = deltas().cos
        let z = -deltas().sin
        moveDrone(x: x, z: z, sender: sender)
    }
    
    @IBAction func moveLeftLongPressed(_ sender: UILongPressGestureRecognizer) {
        let x = -deltas().cos
        let z = -deltas().sin
        moveDrone(x: x, z: z, sender: sender)
    }
    
    private func deltas() -> (sin: CGFloat, cos: CGFloat){
    return (sin: kMovingLengthPerLoop * CGFloat(sin(drone.eulerAngles.y)), cos: kMovingLengthPerLoop * CGFloat(cos(drone.eulerAngles.y)))
    }
    
    private func moveDrone(x: CGFloat, z: CGFloat, sender: UILongPressGestureRecognizer){
        let action = SCNAction.moveBy(x: x, y: 0, z: z, duration: 0.1)
        execute(action: action, sender: sender)
    }
    
    
    private func execute(action: SCNAction, sender: UILongPressGestureRecognizer){
        let loopAction = SCNAction.repeat(action, count: 1)
        if sender.state == .began{
            drone.runAction(loopAction)
        }
        else if sender.state == .ended{
            drone.removeAllActions()
        }
    }
}

extension float4x4{
    var translation: float3{
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

