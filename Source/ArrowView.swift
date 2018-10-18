import UIKit

class ArrowView: UIView {

    enum ArrowOrientation {
        case Up
        case Down
    }

    var orientation: ArrowOrientation = .Up {
        didSet {
            setNeedsDisplay()
        }
    }

    var arrowColor: UIColor = UIColor.white {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let width = rect.width
        let height = rect.height
        let path = UIBezierPath()
        if self.orientation == .Down {
            path.move(to: CGPoint.zero)
            path.addLine(to: CGPoint(x: width, y: 0))
            path.addLine(to: CGPoint(x: width / 2, y: height))
            path.addLine(to: CGPoint.zero)
        } else {
            path.move(to: CGPoint(x: width / 2, y: 0))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: width / 2, y: 0))
        }
        self.arrowColor.setFill()
        path.fill()
    }
}
