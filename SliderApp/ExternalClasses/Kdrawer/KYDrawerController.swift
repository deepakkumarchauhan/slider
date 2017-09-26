/*
Copyright (c) 2015 Kyohei Yamaguchi. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import UIKit

@objc public protocol KYDrawerControllerDelegate {
    @objc optional func drawerController(_ drawerController: KYDrawerController, stateChanged state: KYDrawerController.DrawerState)
}

open class KYDrawerController: UIViewController, UIGestureRecognizerDelegate {
    
    /**************************************************************************/
    // MARK: - Types
    /**************************************************************************/
    
    @objc public enum DrawerDirection: Int {
        case left, right
    }
    
    @objc public enum DrawerState: Int {
        case opened, closed
    }

    /**************************************************************************/
    // MARK: - Properties
    /**************************************************************************/

    @IBInspectable open var containerViewMaxAlpha: CGFloat = 0.2

    @IBInspectable open var drawerAnimationDuration: TimeInterval = 0.25

    @IBInspectable open var mainSegueIdentifier: String?
    
    @IBInspectable open var drawerSegueIdentifier: String?
    
    fileprivate var _drawerConstraint: NSLayoutConstraint!
    
    fileprivate var _drawerWidthConstraint: NSLayoutConstraint!
    
    fileprivate var _panStartLocation = CGPoint.zero
    
    fileprivate var _panDelta: CGFloat = 0
    
    lazy fileprivate var _containerView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.0, alpha: 0)
        view.addGestureRecognizer(self.containerViewTapGesture)
        return view
    }()

    /// Returns `true` if `beginAppearanceTransition()` has been called with `true` as the first parameter, and `false`
    /// if the first parameter is `false`. Returns `nil` if appearance transition is not in progress.
    fileprivate var _isAppearing: Bool?

    open var screenEdgePanGestureEnabled = true
    
    open fileprivate(set) lazy var screenEdgePanGesture: UIScreenEdgePanGestureRecognizer = {
        let gesture = UIScreenEdgePanGestureRecognizer(
            target: self,
            action: #selector(KYDrawerController.handlePanGesture(_:))
        )
        switch self.drawerDirection {
        case .left:     gesture.edges = .left
        case .right:    gesture.edges = .right
        }
        gesture.delegate = self
        return gesture
    }()
    
    open fileprivate(set) lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(KYDrawerController.handlePanGesture(_:))
        )
        gesture.delegate = self
        return gesture
    }()

    open fileprivate(set) lazy var containerViewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(KYDrawerController.didtapContainerView(_:))
        )
        gesture.delegate = self
        return gesture
    }()
    
    open weak var delegate: KYDrawerControllerDelegate?
    
    open var drawerDirection: DrawerDirection = .left {
        didSet {
            switch drawerDirection {
            case .left:  screenEdgePanGesture.edges = .left
            case .right: screenEdgePanGesture.edges = .right
            }
            let tmp = drawerViewController
            drawerViewController = tmp
        }
    }
    
    open var drawerState: DrawerState {
        get { return _containerView.isHidden ? .closed : .opened }
        set { setDrawerState(drawerState, animated: false) }
    }
    
    @IBInspectable open var drawerWidth: CGFloat = 280 {
        didSet { _drawerWidthConstraint?.constant = drawerWidth }
    }

    open var displayingViewController: UIViewController? {
        switch drawerState {
        case .closed:
            return mainViewController
        case .opened:
            return drawerViewController
        }
    }

    open var mainViewController: UIViewController! {
        didSet {
            if let oldController = oldValue {
                oldController.willMove(toParentViewController: nil)
                oldController.view.removeFromSuperview()
                oldController.removeFromParentViewController()
            }

            guard let mainViewController = mainViewController else { return }
            mainViewController.view.frame = CGRect(x: 0, y: 0, width: Window_Width, height: Window_Height)
            addChildViewController(mainViewController)

            mainViewController.view.translatesAutoresizingMaskIntoConstraints = false
            view.insertSubview(mainViewController.view, at: 0)

//            let viewDictionary = ["mainView" : mainViewController.view]
//            view.addConstraints(
//                NSLayoutConstraint.constraintsWithVisualFormat(
//                    "V:|-0-[mainView]-0-|",
//                    options: [],
//                    metrics: nil,
//                    views: viewDictionary
//                )
//            )
//            view.addConstraints(
//                NSLayoutConstraint.constraintsWithVisualFormat(
//                    "H:|-0-[mainView]-0-|",
//                    options: [],
//                    metrics: nil,
//                    views: viewDictionary
//                )
//            )
            self.view.backgroundColor = UIColor(red: 64.0/255.0, green: 67.0/255.0, blue: 74.0/255.0, alpha: 1.0)
            
            mainViewController.didMove(toParentViewController: self)
            
        }
    }
    
    open var drawerViewController : UIViewController? {
        didSet {
            if let oldController = oldValue {
                oldController.willMove(toParentViewController: nil)
                oldController.view.removeFromSuperview()
                oldController.removeFromParentViewController()
            }

            guard let drawerViewController = drawerViewController else { return }
            addChildViewController(drawerViewController)

            drawerViewController.view.layer.shadowColor   = UIColor.black.cgColor
            drawerViewController.view.layer.shadowOpacity = 0.4
            drawerViewController.view.layer.shadowRadius  = 5.0
            drawerViewController.view.translatesAutoresizingMaskIntoConstraints = false
            _containerView.addSubview(drawerViewController.view)

            let itemAttribute: NSLayoutAttribute
            let toItemAttribute: NSLayoutAttribute
            switch drawerDirection {
            case .left:
                itemAttribute   = .right
                toItemAttribute = .left
            case .right:
                itemAttribute   = .left
                toItemAttribute = .right
            }

            _drawerWidthConstraint = NSLayoutConstraint(
                item: drawerViewController.view,
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: nil,
                attribute: NSLayoutAttribute.width,
                multiplier: 1,
                constant: drawerWidth
            )
            drawerViewController.view.addConstraint(_drawerWidthConstraint)
            
            _drawerConstraint = NSLayoutConstraint(
                item: drawerViewController.view,
                attribute: itemAttribute,
                relatedBy: NSLayoutRelation.equal,
                toItem: _containerView,
                attribute: toItemAttribute,
                multiplier: 1,
                constant: 0
            )
            _containerView.addConstraint(_drawerConstraint)

            let viewDictionary = ["drawerView" : drawerViewController.view]
            _containerView.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|-0-[drawerView]-0-|",
                    options: [],
                    metrics: nil,
                    views: viewDictionary
                )
            )
            _containerView.updateConstraints()
            drawerViewController.updateViewConstraints()
            drawerViewController.didMove(toParentViewController: self)
        }
    }
    
    
    /**************************************************************************/
    // MARK: - initialize
    /**************************************************************************/
    
    public convenience init(drawerDirection: DrawerDirection, drawerWidth: CGFloat) {
        self.init()
        self.drawerDirection = drawerDirection
        self.drawerWidth     = drawerWidth
    }
    
    
    /**************************************************************************/
    // MARK: - Life Cycle
    /**************************************************************************/
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let viewDictionary = ["_containerView": _containerView]
        
        view.addGestureRecognizer(screenEdgePanGesture)
        view.addGestureRecognizer(panGesture)
        view.addSubview(_containerView)
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[_containerView]-0-|",
                options: [],
                metrics: nil,
                views: viewDictionary
            )
        )
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[_containerView]-0-|",
                options: [],
                metrics: nil,
                views: viewDictionary
            )
        )
        _containerView.isHidden = true
        
        if let mainSegueID = mainSegueIdentifier {
            performSegue(withIdentifier: mainSegueID, sender: self)
        }
        if let drawerSegueID = drawerSegueIdentifier {
            performSegue(withIdentifier: drawerSegueID, sender: self)
        }
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayingViewController?.beginAppearanceTransition(true, animated: animated)
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayingViewController?.endAppearanceTransition()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        displayingViewController?.beginAppearanceTransition(false, animated: animated)
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        displayingViewController?.endAppearanceTransition()
    }

    // We will manually call `mainViewController` or `drawerViewController`'s
    // view appearance methods.
    override open var shouldAutomaticallyForwardAppearanceMethods : Bool {
        return false
    }

    /**************************************************************************/
    // MARK: - Public Method
    /**************************************************************************/
    
    open func setDrawerState(_ state: DrawerState, animated: Bool) {
        _containerView.isHidden = false
        let duration: TimeInterval = animated ? drawerAnimationDuration : 0

        let isAppearing = state == .opened
        if _isAppearing != isAppearing {
            _isAppearing = isAppearing
            drawerViewController?.beginAppearanceTransition(isAppearing, animated: animated)
            mainViewController?.beginAppearanceTransition(!isAppearing, animated: animated)
        }

        UIView.animate(withDuration: duration,
            delay: 0,
            options: .curveEaseOut,
            animations: { () -> Void in
                switch state {
                case .closed:
                    self._drawerConstraint.constant     = 0
                    self._containerView.backgroundColor = UIColor(white: 0, alpha: 0)
                case .opened:
                    let constant: CGFloat
                    switch self.drawerDirection {
                    case .left:
                        constant = self.drawerWidth
                    case .right:
                        constant = -self.drawerWidth
                    }
                    self._drawerConstraint.constant     = constant
                    self._containerView.backgroundColor = UIColor(
                        white: 0
                        , alpha: self.containerViewMaxAlpha
                    )
                }
                self._containerView.layoutIfNeeded()
            }) { (finished: Bool) -> Void in
                if state == .closed {
                    self._containerView.isHidden = true
                }
                self.drawerViewController?.endAppearanceTransition()
                self.mainViewController?.endAppearanceTransition()
                self._isAppearing = nil
                self.delegate?.drawerController?(self, stateChanged: state)
        }
    }
    
    /**************************************************************************/
    // MARK: - Private Method
    /**************************************************************************/
    
    final func handlePanGesture(_ sender: UIGestureRecognizer) {
        _containerView.isHidden = false
        if sender.state == .began {
            _panStartLocation = sender.location(in: view)
        }
        
        let delta           = CGFloat(sender.location(in: view).x - _panStartLocation.x)
        let constant        : CGFloat
        let backGroundAlpha : CGFloat
        let drawerState     : DrawerState
        
        switch drawerDirection {
        case .left:
            drawerState     = _panDelta <= 0 ? .closed : .opened
            constant        = min(_drawerConstraint.constant + delta, drawerWidth)
            backGroundAlpha = min(
                containerViewMaxAlpha,
                containerViewMaxAlpha*(abs(constant)/drawerWidth)
            )
        case .right:
            drawerState     = _panDelta >= 0 ? .closed : .opened
            constant        = max(_drawerConstraint.constant + delta, -drawerWidth)
            backGroundAlpha = min(
                containerViewMaxAlpha,
                containerViewMaxAlpha*(abs(constant)/drawerWidth)
            )
        }
        
        _drawerConstraint.constant = constant
        _containerView.backgroundColor = UIColor(
            white: 0,
            alpha: backGroundAlpha
        )
        
        switch sender.state {
        case .changed:
            let isAppearing = drawerState != .opened
            if _isAppearing == nil {
                _isAppearing = isAppearing
                drawerViewController?.beginAppearanceTransition(isAppearing, animated: true)
                mainViewController?.beginAppearanceTransition(!isAppearing, animated: true)
            }

            _panStartLocation = sender.location(in: view)
            _panDelta         = delta
        case .ended, .cancelled:
            setDrawerState(drawerState, animated: true)
        default:
            break
        }
    }
    
    final func didtapContainerView(_ gesture: UITapGestureRecognizer) {
        setDrawerState(.closed, animated: true)
    }
    
    
    /**************************************************************************/
    // MARK: - UIGestureRecognizerDelegate
    /**************************************************************************/
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        switch gestureRecognizer {
        case panGesture:
            return drawerState == .opened
        case screenEdgePanGesture:
            return screenEdgePanGestureEnabled ? drawerState == .closed : false
        default:
            return touch.view == gestureRecognizer.view
        }
   }

}
