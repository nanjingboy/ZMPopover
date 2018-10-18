import UIKit
import SnapKit
import ZMPopover

class ViewController: UIViewController {

    fileprivate let popoverView = PopoverView()

    fileprivate let leftTopBtn = UIButton()
    fileprivate let rightTopBtn = UIButton()
    fileprivate let leftBottomBtn = UIButton()
    fileprivate let rightBottomBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        self.leftTopBtn.backgroundColor = UIColor.gray
        self.leftTopBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.leftTopBtn.setTitle("Horizontal Scroll Popover", for: .normal)
        self.leftTopBtn.addTarget(self, action: #selector(showHorizontalScrollPopover(_:)), for: .touchUpInside)
        self.view.addSubview(self.leftTopBtn)
        self.leftTopBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.top.equalTo(self.view).offset(60)
            make.width.equalTo(180)
            make.height.equalTo(60)
        }

        self.rightTopBtn.backgroundColor = UIColor.gray
        self.rightTopBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.rightTopBtn.setTitle("Vertical Scroll Popover", for: .normal)
        self.rightTopBtn.addTarget(self, action: #selector(showVerticalScrollPopover(_:)), for: .touchUpInside)
        self.view.addSubview(self.rightTopBtn)
        self.rightTopBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-10)
            make.top.equalTo(self.view).offset(60)
            make.width.equalTo(180)
            make.height.equalTo(60)
        }

        self.leftBottomBtn.backgroundColor = UIColor.gray
        self.leftBottomBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.leftBottomBtn.setTitle("Horizontal Scroll Popover", for: .normal)
        self.leftBottomBtn.addTarget(self, action: #selector(showHorizontalScrollPopover(_:)), for: .touchUpInside)
        self.view.addSubview(self.leftBottomBtn)
        self.leftBottomBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.bottom.equalTo(self.view).offset(-60)
            make.width.equalTo(180)
            make.height.equalTo(60)
        }

        self.rightBottomBtn.backgroundColor = UIColor.gray
        self.rightBottomBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.rightBottomBtn.setTitle("Vertical Scroll Popover", for: .normal)
        self.rightBottomBtn.addTarget(self, action: #selector(showVerticalScrollPopover(_:)), for: .touchUpInside)
        self.view.addSubview(self.rightBottomBtn)
        self.rightBottomBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view).offset(-60)
            make.width.equalTo(180)
            make.height.equalTo(60)
        }
        self.popoverView.viewController = self
    }

    @objc func showHorizontalScrollPopover(_ sender: UIButton) {
        let contentView = UILabel()
        contentView.text = "hello world"
        contentView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        self.popoverView.show(sender,
                              contentView: contentView,
                              popoverSize: CGSize(width: 100, height: 100),
                              popoverMargin: .zero,
                              scrollOrientation: .Horizontal)
    }

    @objc func showVerticalScrollPopover(_ sender: UIButton) {
        let contentView = UILabel()
        contentView.text = "hello world"
        contentView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        self.popoverView.show(sender,
                              contentView: contentView,
                              popoverSize: CGSize(width: 100, height: 100),
                              popoverMargin: .zero,
                              scrollOrientation: .Vertical)
    }
}
