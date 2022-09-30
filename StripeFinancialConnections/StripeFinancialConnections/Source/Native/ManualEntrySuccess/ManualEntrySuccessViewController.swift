//
//  ManualEntrySuccessViewController.swift
//  StripeFinancialConnections
//
//  Created by Krisjanis Gaidis on 8/29/22.
//

import Foundation
import UIKit
@_spi(STP) import StripeUICore

protocol ManualEntrySuccessViewControllerDelegate: AnyObject {
    func manualEntrySuccessViewControllerDidFinish(_ viewController: ManualEntrySuccessViewController)
}

final class ManualEntrySuccessViewController: UIViewController {
    
    private let microdepositVerificationMethod: MicrodepositVerificationMethod?
    private let accountNumberLast4: String
    
    weak var delegate: ManualEntrySuccessViewControllerDelegate?
    
    init(
        microdepositVerificationMethod: MicrodepositVerificationMethod?,
        accountNumberLast4: String
    ) {
        self.microdepositVerificationMethod = microdepositVerificationMethod
        self.accountNumberLast4 = accountNumberLast4
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBackgroundColor
        navigationItem.hidesBackButton = true
        
        let paneWithHeaderLayoutView = PaneWithHeaderLayoutView(
            icon: .view(SuccessIconView()),
            title: STPLocalizedString("Micro-deposits initiated", "The title of a screen that instructs user that they will receive micro-deposists (small payments like '$0.01') in their bank account."),
            subtitle: {
                let subtitle: String
                if microdepositVerificationMethod == .descriptorCode {
                    subtitle = String(format: STPLocalizedString("Expect a $0.01 deposit to the account ending in ****%@ in 1-2 business days and an email with additional instructions to verify your bank account.", "The subtitle of a screen that instructs user that they will receive micro-deposists (small payments like '$0.01') in their bank account. '%@' is replaced by the last 4 digits of a bank account number, ex. 6489."), accountNumberLast4)
                } else {
                    subtitle = String(format: STPLocalizedString("Expect two small deposits to the account ending in ••••%@ in 1-2 business days and an email with additional instructions to verify your bank account.", "The subtitle of a screen that instructs user that they will receive micro-deposists (small payments like '$0.01') in their bank account. '%@' is replaced by the last 4 digits of a bank account number, ex. 6489."), accountNumberLast4)
                }
                return subtitle
            }(),
            contentView: ManualEntrySuccessTransactionTableView(
                microdepositVerificationMethod: microdepositVerificationMethod,
                accountNumberLast4: accountNumberLast4
            ),
            footerView: CreateFooterView(self)
        )
        paneWithHeaderLayoutView.addTo(view: view)
    }
    
    @objc fileprivate func didSelectDone() {
        delegate?.manualEntrySuccessViewControllerDidFinish(self)
    }
}

// MARK: - Helpers

private func CreateFooterView(_ buttonTarget: ManualEntrySuccessViewController) -> UIView {
    let doneButton = Button(
        configuration: {
            var doneButtonConfiguration = Button.Configuration.primary()
            doneButtonConfiguration.font = .stripeFont(forTextStyle: .bodyEmphasized)
            doneButtonConfiguration.backgroundColor = .textBrand
            return doneButtonConfiguration
        }()
    )
    doneButton.title = "Done" // TODO: replace with UIButton.doneButtonTitle once the SDK is localized
    doneButton.addTarget(
        buttonTarget,
        action: #selector(ManualEntrySuccessViewController.didSelectDone),
        for: .touchUpInside
    )
    doneButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        doneButton.heightAnchor.constraint(equalToConstant: 56),
    ])
    let verticalStackView = UIStackView(
        arrangedSubviews: [
            doneButton,
        ]
    )
    verticalStackView.axis = .vertical
    return verticalStackView
}
