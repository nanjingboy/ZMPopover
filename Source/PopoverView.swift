import UIKit

open class PopoverView: UIView {

    public enum ScrollOrientation {
        case Horizontal
        case Vertical
    }

    public weak var viewController: UIViewController?
    public var arrowSize: CGFloat = 12
    public var popoverBgColor: UIColor = UIColor.white

    fileprivate var windowSize: CGSize = CGSize.zero

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }

    public func show(_ anchor: UIView,
                     contentView: UIView,
                     popoverSize: CGSize,
                     popoverMargin: UIEdgeInsets = UIEdgeInsets.zero,
                     scrollOrientation: ScrollOrientation = .Horizontal) {
        if self.isShowing() {
            return
        }
        guard let rootView = self.viewController?.view,
            let anchorLocation = anchor.superview?.convert(anchor.frame.origin, to: nil) else {
            return
        }

        self.windowSize = rootView.frame.size
        let anchorLayout = CGRect(x: anchorLocation.x,
                                  y: anchorLocation.y,
                                  width: anchor.frame.width,
                                  height: anchor.frame.height)
        let arrowOrientation = self.parseArrowOrientation(anchorLayout,
                                                          popoverSize: popoverSize,
                                                          popoverMargin: popoverMargin)
        let realPopoverSize = self.parsePopoverSize(arrowOrientation,
                                                    anchorLayout: anchorLayout,
                                                    popoverSize: popoverSize,
                                                    popoverMargin: popoverMargin)

        let arrowTop: CGFloat
        let popoverTop: CGFloat
        if arrowOrientation == ArrowView.ArrowOrientation.Down {
            arrowTop = anchorLayout.origin.y - self.arrowSize
            popoverTop = arrowTop - realPopoverSize.height
        } else {
            arrowTop = anchorLayout.origin.y + anchorLayout.height
            popoverTop = arrowTop + self.arrowSize
        }

        let maxPopoverLeft = self.windowSize.width - realPopoverSize.width - popoverMargin.right
        var popoverLeft = anchorLayout.origin.x + (anchorLayout.width - realPopoverSize.width) / 2
        if popoverLeft < popoverMargin.left {
            popoverLeft = popoverMargin.left
        } else if popoverLeft > maxPopoverLeft {
            popoverLeft = maxPopoverLeft
        }

        let maxArrowLeft = popoverLeft + realPopoverSize.width - self.arrowSize
        var arrowLeft = anchorLayout.origin.x + (anchorLayout.width - self.arrowSize) / 2
        if arrowLeft < popoverLeft {
            arrowLeft = popoverLeft
        } else if arrowLeft > maxArrowLeft {
            arrowLeft = maxArrowLeft
        }

        let arrowView = ArrowView()
        arrowView.orientation = arrowOrientation
        arrowView.backgroundColor = UIColor.clear
        arrowView.arrowColor = self.popoverBgColor
        arrowView.frame = CGRect(x: arrowLeft, y: arrowTop, width: self.arrowSize, height: self.arrowSize)
        self.addSubview(arrowView)

        let contentSize = CGSize(width: max(contentView.frame.width, realPopoverSize.width),
                                 height: max(contentView.frame.size.height, realPopoverSize.height))
        let scrollView = UIScrollView()
        scrollView.contentSize = contentSize
        scrollView.frame = CGRect(x: popoverLeft,
                                  y: popoverTop,
                                  width: realPopoverSize.width,
                                  height: realPopoverSize.height)
        contentView.backgroundColor = self.popoverBgColor
        contentView.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)

        self.frame = rootView.frame
        rootView.addSubview(self)
    }

    public func isShowing() -> Bool {
        return self.viewController?.view.subviews.contains(self) ?? false
    }

    @objc public func hide() {
        if self.isShowing() {
            self.subviews.forEach { $0.removeFromSuperview() }
            self.removeFromSuperview()
        }
    }

    fileprivate func initView() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
    }

    fileprivate func parseArrowOrientation(_ anchorLayout: CGRect,
                                           popoverSize: CGSize,
                                           popoverMargin: UIEdgeInsets) -> ArrowView.ArrowOrientation {
        let maxPopoverTop = anchorLayout.origin.y
            + anchorLayout.height
            + self.arrowSize
            + popoverSize.height
            + popoverMargin.bottom
        if maxPopoverTop > self.windowSize.height {
            let maxWindowSpace = self.windowSize.height - anchorLayout.origin.y - anchorLayout.height
            return anchorLayout.origin.y > maxWindowSpace ? ArrowView.ArrowOrientation.Down : ArrowView.ArrowOrientation.Up
        }
        return ArrowView.ArrowOrientation.Up
    }

    fileprivate func parsePopoverSize(_ arrowOrientation: ArrowView.ArrowOrientation,
                                      anchorLayout: CGRect,
                                      popoverSize: CGSize,
                                      popoverMargin: UIEdgeInsets) -> CGSize {
        var width = popoverSize.width
        let maxWidth =  windowSize.width - popoverMargin.left - popoverMargin.right;
        if width <= 0 || width > maxWidth {
            width = maxWidth;
        }

        let maxHeight: CGFloat
        if arrowOrientation == .Down {
            maxHeight = anchorLayout.origin.y - popoverMargin.top - self.arrowSize
        } else {
            maxHeight = self.windowSize.height
                - anchorLayout.origin.y
                - anchorLayout.height
                - self.arrowSize
                - popoverMargin.bottom
        }
        var height = popoverSize.height
        if height > maxHeight {
            height = maxHeight
        }
        return CGSize(width: width, height: height)
    }
}
