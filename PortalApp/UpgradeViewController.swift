//
//  UpgradeViewController.swift
//  PortalApp
//
//  Created by Ben Scheirman on 1/19/21.
//

import UIKit
import SnapKit
import BonMot

let termsURL = URL(string: "https://portal.app")!

class UpgradeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .primaryBlue
    
        configureSubviews()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        
        let background = BackgroundView()
        view.addSubview(background)
       
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 24
        contentStack.alignment = .center
        contentStack.distribution = .fill
        
        view.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(14)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-14)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        
        let label1 = UILabel()
        label1.numberOfLines = 0
        label1.attributedText = "Unlock the World.\nFree for 7 Days.".styled(with: .largeHeaderStyle)
        contentStack.addArrangedSubview(label1)
        
        let label2 = UILabel()
        label2.numberOfLines = 0
        label2.textAlignment = .center
        label2.textColor = .white
        contentStack.addArrangedSubview(label2)

        label2.attributedText = """
            Enjoy <bold>Full Access</bold> to the Portal Library.
            <bold>Free for 7 days, then £29.99/year</bold>.
            """.styled(with: .pricingTextStyle)
        
        let tryButton = RoundedButton()
        tryButton.setTitle("Try it Free", for: .normal)
        contentStack.addArrangedSubview(tryButton)
        tryButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        let termsTextView = UITextView()

    
        
        let termsAttrString = """
            By continuing you agree to our <terms>Terms &amp; Conditions</terms>.
            Portal members renews automatically unless auto-renew is turned off at least 24h before the trial period ends.
            """.styled(with: .termsStyle)
        
        termsTextView.isSelectable = true
        termsTextView.linkTextAttributes = StringStyle.termsLinkStyle.attributes
        termsTextView.attributedText = termsAttrString
        contentStack.addArrangedSubview(termsTextView)
        
        termsTextView.isScrollEnabled = false
        termsTextView.isEditable = false
        termsTextView.backgroundColor = .clear
    }
}

class BackgroundView: CustomView {
    override func setupView() {
        let imageView = UIImageView(image: UIImage(named: "night-scene"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        let fadeToBlack = GradientView()
        fadeToBlack.isOpaque = false
        fadeToBlack.startColor = .clear
        fadeToBlack.endColor = .black
        fadeToBlack.locations = [0.25, 0.58]
        addSubview(fadeToBlack)
        
        fadeToBlack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

fileprivate extension StringStyle {
    static var largeHeaderStyle: StringStyle {
        StringStyle(
            .color(.white),
            .alignment(.center),
            .font(.boldSystemFont(ofSize: 38))
        )
    }
    
    static var pricingTextStyle: StringStyle {
        StringStyle(
            .color(.white),
            .lineSpacing(10),
            .alignment(.center),
            .font(.systemFont(ofSize: 20, weight: .ultraLight)),
            .xmlRules([
                .style("bold", .init(.font(.boldSystemFont(ofSize: 20))))
            ])
        )
    }
    
    static var termsStyle: StringStyle {
        StringStyle(
            .color(.systemGray4),
            .alignment(.center),
            .font(.systemFont(ofSize: 14, weight: .ultraLight)),
            .tracking(.point(-0.5)),
            .paragraphSpacingAfter(5),
            .xmlRules([
                .style("terms", termsLinkStyle)
            ])
        )
    }
    
    static var termsLinkStyle: StringStyle {
        StringStyle(
            .color(.systemGray3),
            .alignment(.center),
            .font(.systemFont(ofSize: 14, weight: .bold)),
            .tracking(.point(-0.5)),
            .underline(.single, nil),
            .link(termsURL)
        )
    }
}

#if DEBUG
import SwiftUI

struct UpgradeViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview<UpgradeViewController>()
            .edgesIgnoringSafeArea(.all)
    }

}
#endif
