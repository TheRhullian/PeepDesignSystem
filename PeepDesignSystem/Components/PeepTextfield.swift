//
//  PeepTextfield.swift
//  PeepDesignSystem
//
//  Created by Rhullian Damião on 13/03/22.
//

import UIKit

public class PeepTextfield: UIView {
    // MARK: - Properties
    public var maskType: MaskTypes = .none
    
    /// Constantes que são aplicadas na configuração do Componente
    enum Constants {
        //Shadow
        static let shadowColor: UIColor = .black
        static let shadowOffset: CGSize = .init(width: -3, height: 8)
        static let shadowOppacity: Float = 0.3
        static let shadowRadius: CGFloat = 8
        static let shadowRadiusDisable: CGFloat = 4
        static let shadowOppacityDisable: Float = 0.1
        
        // Borda
        static let borderColor: UIColor = .blue.withAlphaComponent(0.5)
        static let borderWidth: CGFloat = 2
    }
    
    
    /// Tipos de Máscara
    public enum MaskTypes {
        case none
        case cpf
        case cnpj
        case cep
        case cellphone
        case creditCard
        
        var mask: String? {
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
            case .none:
                return nil
            }
        }
        
        var maximumChars: Int? {
            switch self {
            case .cpf, .cellphone:
                return 11
            case .cnpj:
                return 14
            case .cep:
                return 8
            case .creditCard:
                return 16
            case .none:
                return nil
            }
        }
        
    }
    
    
    // MARK: - UI
    
    /// View que vai estar com o conteúdo para exibição
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews([
            textfield
        ])
        
        return view
    }()
    
    
    private lazy var textfield: UITextField = {
        let textfield = UITextField(frame: .zero)
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .none
        textfield.delegate = self
        
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
        setupContentBorder()
        applyShadow(isFieldBeingEdited: false)
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func setupContentBorder() {
        // Cor da Borda
        self.contentView.layer.borderColor = Constants.borderColor.cgColor
        // Largura da Borda
        self.contentView.layer.borderWidth = Constants.borderWidth
    }
    
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
            textfield.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -12),
            textfield.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textfield.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textfield.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    /// Função responsável por fazer toda alteração necessária na sombra
    /// - Parameter isFieldBeingEdited: Campo de texto acionado
    private func applyShadow(isFieldBeingEdited: Bool) {
        // Cor da sombra
        self.contentView.layer.shadowColor = Constants.shadowColor.cgColor
        // Deslocamento da sombra
        self.contentView.layer.shadowOffset = Constants.shadowOffset
        
        UIView.animate(withDuration: 0.3) {
            // Desfoque da sombra
            self.contentView.layer.shadowRadius = isFieldBeingEdited ? Constants.shadowRadius : Constants.shadowRadiusDisable
            // Opacidade da Sombra
            self.contentView.layer.shadowOpacity = isFieldBeingEdited ? Constants.shadowOppacity : Constants.shadowOppacityDisable
        }
    }
    
    
    /// Função responsável por retirar todos os símbolo e somente manter números e letras
    /// - Parameter text: String para Formatar
    private func getOnlyDigitsFromString(text: String) -> String {
        return text.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
    }
    
    
    /// Aplicar máscara no texto digitado no campo de texto
    /// - Parameters:
    ///   - text: Texto para aplicar
    ///   - mask: Máscara para ser aplicada
    private func applyMaskToText(text: String, apply mask: String?) {
        
        var masked = ""
        var textIndex = 0
        var maskIndex = 0
        
        guard let mask = mask else {
            textfield.text = text
            return
        }
        
        let onlyChars = getOnlyDigitsFromString(text: text)
        
        while (maskIndex < mask.count && textIndex < onlyChars.count) {
            var char = mask[mask.index(mask.startIndex, offsetBy: maskIndex)]
            
            if char == "#" {
                char = onlyChars[text.index(onlyChars.startIndex, offsetBy: textIndex)]
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
        applyMaskToText(text: text, apply: maskType.mask)
        if let maxChars = maskType.maximumChars, text.count > maxChars {
            _ = textfield.text?.dropLast()
        }
    }
}

extension PeepTextfield: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        applyShadow(isFieldBeingEdited: true)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        applyShadow(isFieldBeingEdited: false)
    }
}
