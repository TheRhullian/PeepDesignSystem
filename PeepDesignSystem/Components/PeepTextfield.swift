//
//  PeepTextfield.swift
//  PeepDesignSystem
//
//  Created by Rhullian Damião on 13/03/22.
//

import UIKit

public class PeepTextfield: UIView {
    // MARK: - Properties
    enum MaskTypes {
        case cpf
        case cnpj
        case cep
        case cellphone
        case creditCard
        
        var mask: String {
            switch self {
            case .cpf:
                return "###.###.###-##"
            case .cnpj:
                return "##.###.###/####-##"
            case .cep:
                return "#####-###"
            case .cellphone:
                return "(##) #####-####"
            case .creditCard:
                return "#### #### #### ####"
            }
        }
        
        var maximumChars: Int {
            switch self {
            case .cpf, .cellphone:
                return 11
            case .cnpj:
                return 14
            case .cep:
                return 8
            case .creditCard:
                return 16
            }
        }
        
    }
    
    
    // MARK: - UI
    
    /// View que vai estar com o conteúdo para exibição
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews([
            textfield
        ])
        
        return view
    }()
    
    
    private lazy var textfield: UITextField = {
        let textfield = UITextField(frame: .zero)
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .roundedRect

        textfield.addTarget(self, action: #selector(textfieldChaged(_:)), for: .editingChanged)
        
        return textfield
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    /// Função responsável pelo setup das constraints
    private func setupConstraints() {
        self.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            //CONTENT VIEW CONTRAINTS
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //TEXTFIElD CONSTRAINTS
            textfield.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            textfield.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            textfield.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textfield.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
    /// Função responsável por retirar todos os símbolo e somente manter números e letras
    /// - Parameter text: String para Formatar
    private func getOnlyDigitsFromString(text: String) -> String {
        return text.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
    }
    
    private func applyMaskToText(textChars: String, apply mask: String?) {
        
        var masked = ""
        var textIndex = 0
        var maskIndex = 0
        
        guard let mask = mask else {
            textfield.text = textChars
            return
        }

        while (maskIndex < mask.count && textIndex < textChars.count) {
            var char = mask[mask.index(mask.startIndex, offsetBy: maskIndex)]
            
            if char == "#" {
                char = textChars[textChars.index(textChars.startIndex, offsetBy: textIndex)]
                textIndex += 1
            }
            
            masked.append(char)
            maskIndex += 1
        }
        
        textfield.text = masked
    }
    
    /// Função reponsável por aplicar ações conforme o usuário digita
    /// - Parameter textfield: Textfield sofrendo edição
    @objc func textfieldChaged(_ textfield: UITextField) {
        guard let text = textfield.text else { return }
        var mask: String?

        let onlyChars = getOnlyDigitsFromString(text: text)

        switch onlyChars.count {
        case MaskTypes.cellphone.maximumChars:
            if onlyChars.isValidCPF {
                mask = MaskTypes.cpf.mask
            } else {
                mask = MaskTypes.cellphone.mask
            }
        case MaskTypes.cep.maximumChars:
            mask = MaskTypes.cep.mask
        case MaskTypes.cnpj.maximumChars:
            mask = MaskTypes.cnpj.mask
        case MaskTypes.creditCard.maximumChars:
            mask = MaskTypes.creditCard.mask
        default:
            mask = nil
        }

        applyMaskToText(textChars: onlyChars, apply: mask)
    }
    
}
