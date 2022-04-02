//
//  FormTableViewCell.swift
//  instaClone
//
//  Created by Fedii Ihor on 02.04.2022.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell {
    
    static let id = "FormTableViewCell"
    private var model: EditProfileFormModel?
    public weak var delegate: FormTableViewCellDelegate?
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
        let fld = UITextField()
        fld.returnKeyType = .done
        return fld
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate =  self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = .init(x: 5,
                                y: 0,
                                width: contentView.width/3,
                                height: contentView.height)
        field.frame = .init(x: formLabel.right + 5,
                            y: 0,
                            width: contentView.width - 10 - formLabel.width,
                            height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    public func configureCell(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
}

extension FormTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else { return true}
       delegate?.formTableViewCell(self, didUpdateField:  model)
        textField.resignFirstResponder()
        return true
    }
}
