import PlaygroundSupport
import SpriteKit


public class BlueScene: ObstaclesScene {
    override public func didMove(to view: SKView) {
        // Setup physics world
        self.setupPhysicsWorld()
        
        // Setup scene
        self.backgroundColor = grayColors.light
        self.scaleMode = .aspectFill
        
        // Start scene nodes
        self.setupPerson()
        self.customPerson()
        self.setupObstacles()
        self.setupAceptance(rainbowColors.blue)
    }
    
    // Custom person
    func customPerson() {
        let colors = [
            rainbowColors.red,
            rainbowColors.orange,
            rainbowColors.yellow,
            rainbowColors.green,
        ]
        
        let radius: [CGFloat] = [
            90/2,
            75/2,
            60/2,
            45/2,
        ]
        
        for (color, radius) in zip(colors, radius) {
            let redCircum = SKShapeNode(circleOfRadius: radius)
            redCircum.fillColor = UIColor.black
            redCircum.lineWidth = 4
            redCircum.strokeColor = color
            redCircum.position = CGPoint(x: 0, y: 0)
            
            self.personNode.addChild(redCircum)
        }
    }
    
    // Setup obstacles
    func setupObstacles() {
        let sizes = [
            (w: 110, h: 10), // 6
            (w: 10, h: 110), // 7
        ]
        
        let positions = [
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
            
            let purpleView = SKView(frame: CGRect(x:0 , y:0, width: 750, height: 540))
            let purpleScene = PurpleScene(size: CGSize(width: 750, height: 540))

            purpleView.presentScene(purpleScene)
            PlaygroundPage.current.liveView = purpleView
        }
    }
}
