//
//  TimerSelectorViewController.swift
//  FocOn
//
//  Created by Nikita Zhukov on 15.01.2022.
//

import UIKit

protocol TimerSelectorViewStyler {
    func background(view: UIView)
    func content(view: UIView)
    func ringPlaceholder(view: UIView)
    
    func start(button: UIButton)
    func close(button: UIButton)
    func restTimeUp(button: UIButton)
    func restTimeDown(button: UIButton)
    
    func title(label: UILabel)
    func restTimeTitle(label: UILabel)
    func restTimeValue(label: UILabel, value: String)
}

final class TimerSelectorViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var viewRingPlaceholder: UIView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelRestTimeTitle: UILabel!
    @IBOutlet private weak var labelRestTimeValue: UILabel!
    @IBOutlet private weak var buttonRestTimeUp: UIButton!
    @IBOutlet private weak var buttonRestTimeDown: UIButton!
    @IBOutlet private weak var buttonClose: UIButton!
    @IBOutlet private weak var buttonStart: UIButton!
    
    var onCloseComplition: (() -> Void)?
    var onStartComplition: ((_ value: Int) -> Void)?
    
    var styler: TimerSelectorViewStyler!
    var appValues: AppValues!
    
    // MARK: - Initialization

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyStyles()
    }

    // MARK: - Methods
    // MARK: Private methods
    
    @IBAction private func closeHandler(_ sender: Any) {
        onCloseComplition?()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func startHandler(_ sender: Any) {
        onStartComplition?(0)
        dismiss(animated: true, completion: nil)
    }
    
    private func applyStyles() {
        styler.background(view: view)
        styler.content(view: viewContent)
        styler.ringPlaceholder(view: viewRingPlaceholder)
        
        styler.start(button: buttonStart)
        styler.close(button: buttonClose)
        styler.restTimeUp(button: buttonRestTimeUp)
        styler.restTimeDown(button: buttonRestTimeDown)
        
        styler.title(label: labelTitle)
        styler.restTimeTitle(label: labelRestTimeTitle)
        styler.restTimeValue(label: labelRestTimeValue, value: "\(appValues.restTimerDelta)")
    }
}
