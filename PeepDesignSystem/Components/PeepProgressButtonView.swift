//
//  PeepProgressButtonView.swift
//  PeepDesignSystem
//
//  Created by Rhullian Damião on 16/03/22.
//

import UIKit

public class PeepProgressButtonView: UIView {
    // MARK: - Private Properties
    private enum Constants {
        // BUTTON
        static let buttonHeight: CGFloat = 55
        static let buttonBorderWidth: CGFloat = 2
        static let buttonCornerRadius: CGFloat = 4
        static let buttonHorizontalPadding: CGFloat = 5
        static let buttonBorderColor: UIColor = UIColor.black
        static let buttonTitleColor: UIColor = .white
        
        // PROGRESS
        static let progressViewCornerRadius: CGFloat = 8
    }
    
    var progressWidthAnchor: NSLayoutConstraint? {
        willSet {
            self.progressWidthAnchor?.isActive = false
        }
        didSet {
            self.progressWidthAnchor?.isActive = true
        }
    }
    
    // MARK: - UI
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = Constants.buttonBorderWidth
        view.layer.borderColor = Constants.buttonBorderColor.cgColor
        view.backgroundColor = Constants.buttonBorderColor
        view.layer.cornerRadius = Constants.buttonCornerRadius
        view.addSubviews([
            progressView,
            titleButton
        ])
        
        return view
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView(frame: .zero)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.buttonBorderColor
        view.layer.cornerRadius = Constants.buttonCornerRadius
        view.alpha = 0
        
        return view
    }()
    
    private lazy var titleButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirmar", for: .normal)
        button.setTitleColor(Constants.buttonTitleColor, for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    public var progressPercentage: CGFloat? {
        didSet {
            guard let newValue = progressPercentage else { return }
            self.progressWidthAnchor = self.progressView.widthAnchor.constraint(equalTo: self.titleButton.widthAnchor, multiplier: newValue)
            self.animateProgressBar(currentValue: newValue)
        }
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupConstraints() {
        self.addSubview(contentView)
        
        self.resetProgressContraints()
        // BUTTON
        NSLayoutConstraint.activate([
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.titleButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            self.titleButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.titleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            self.titleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.buttonHorizontalPadding),
            self.titleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.buttonHorizontalPadding),
            
            self.progressView.heightAnchor.constraint(equalTo: titleButton.heightAnchor, constant: -10),
            self.progressView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            self.progressView.leadingAnchor.constraint(equalTo: titleButton.leadingAnchor)
        ])
        
        
    }
    
    /// Função de ação de Toque no Botão
    /// - Parameter sender: Botão que foi pressionado
    @objc private func buttonDidTapped(_ sender: UIButton) {
        hideButtonAnimation()
        var index: CGFloat = 0.0
        while index <= 1 {
            self.progressPercentage = index
            index += 0.1
        }
    }
    
    
    /// Função que anima ocultar o botão
    private func hideButtonAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.backgroundColor = .clear
            self.titleButton.setTitle(nil, for: .normal)
            self.progressView.alpha = 1
        }
    }
    
    /// Função anima a exibição do botão
    private func showButtonAnimation() {
        UIView.animate(withDuration: 0.3, delay: 2) {
            self.contentView.backgroundColor = .black
            self.progressView.alpha = 0
        } completion: { _ in
            self.titleButton.setTitle("Confirmar", for: .normal)
            self.resetProgressContraints()
        }
    }
    
    /// Função Responsável pela animação da progress bar
    private func animateProgressBar(currentValue: CGFloat) {
        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        } completion: { _ in
            print(currentValue)
            if currentValue >= 0.99 {
                UIView.animate(withDuration: 0.3) {
                    self.titleButton.setTitle("Sucesso!", for: .normal)
                } completion: { _ in
                    self.showButtonAnimation()
                }
            }
        }
    }
    
    private func resetProgressContraints() {
        self.progressWidthAnchor = self.progressView.widthAnchor.constraint(equalTo: titleButton.widthAnchor,
                                                                            multiplier: 0)
    }
    
    // MARK: - Public Methods

}
