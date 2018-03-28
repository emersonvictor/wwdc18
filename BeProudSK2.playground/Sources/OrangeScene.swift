import PlaygroundSupport
import SpriteKit


public class OrangeScene: ObstaclesScene {
    override public func didMove(to view: SKView) {
        // Setup physics world
        self.setupPhysicsWorld()
        
        // Setup scene
        self.backgroundColor = grayColors.dark
        self.scaleMode = .aspectFill
        
        // Start scene nodes
        self.setupPerson()
        self.customPerson()
        self.setupObstacles()
        self.setupAceptance(rainbowColors.orange)
    }
    
    // Custom person
    func customPerson() {
        let redCircum = SKShapeNode(circleOfRadius: 90/2)
        redCircum.fillColor = UIColor.black
        redCircum.lineWidth = 4
        redCircum.strokeColor = rainbowColors.red
        redCircum.position = CGPoint(x: 0, y: 0)
        
        self.personNode.addChild(redCircum)
    }
    
    // Setup obstacles
    func setupObstacles() {
        let sizes = [
            (w: 250, h: 10), // 2
            (w: 10, h: 240), // 3
            (w: 500, h: 10), // 4
            (w: 10, h: 445), // 5
            (w: 110, h: 10), // 6
            (w: 10, h: 110), // 7
        ]
        
        let positions = [
            CGPoint(x: 0, y: 200),   // 2
            CGPoint(x: 250, y: 200), // 3
            CGPoint(x: 125, y: 95),  // 4
            CGPoint(x: 440, y: 95),  // 5
            CGPoint(x: 640, y: 250), // 6
            CGPoint(x: 640, y: 250), // 7
        ]
        
        var obstacles: SKShapeNode
        for (size, position) in zip(sizes, positions) {
            obstacles = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.w, height: size.h))
            obstacles.fillColor = UIColor.black
            obstacles.position = position
            obstacles.lineWidth = 0
            
            obstacles.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.w, height: size.h), center: CGPoint(x: size.w/2, y: size.h/2))
            obstacles.physicsBody?.affectedByGravity = false
            obstacles.physicsBody?.pinned = true
            obstacles.physicsBody?.allowsRotation = false
            obstacles.physicsBody?.isDynamic = false
            obstacles.physicsBody?.categoryBitMask = PhysicsCategory.Obstacles
            obstacles.physicsBody?.contactTestBitMask = PhysicsCategory.Person
            obstacles.physicsBody?.collisionBitMask = PhysicsCategory.Person
            obstacles.physicsBody?.mass = 999
            
            self.addChild(obstacles)
        }
    }
    
    // Physics bodies colission
    override public func didBegin(_ contact: SKPhysicsContact) {
        self.personNode.removeAction(forKey: "moving")
        if contact.bodyA.categoryBitMask == PhysicsCategory.Acceptance ||
            contact.bodyB.categoryBitMask == PhysicsCategory.Acceptance {
            
            let acceptYourself = SKAction.fadeOut(withDuration: 1)
            self.acceptanceNode.run(acceptYourself)
            
            let yellowView = SKView(frame: CGRect(x:0 , y:0, width: 750, height: 540))
            let yellowScene = YellowScene(size: CGSize(width: 750, height: 540))
            
            yellowView.presentScene(yellowScene)
            PlaygroundPage.current.liveView = yellowView
        }
    }
}
