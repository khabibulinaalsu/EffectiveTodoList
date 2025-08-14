import UIKit

final class TodoListCell: UITableViewCell {
    
    private let completenessIndicator = UIButton()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let createDateLabel = UILabel()
    private var buttonAction: ((Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTodo(_ todo: Todo, action: @escaping (Bool) -> Void) {
        completenessIndicator.tintColor = todo.isCompleted ? .systemYellow : .label.withAlphaComponent(0.5)
        completenessIndicator.isSelected = todo.isCompleted
        
        titleLabel.attributedText = NSMutableAttributedString(string: todo.title)
        titleLabel.opacity(todo.isCompleted ? 0.5 : 1)
        titleLabel.strikethrough(todo.isCompleted)
        
        descriptionLabel.text = todo.text
        descriptionLabel.opacity(todo.isCompleted ? 0.5 : 1)
        
        createDateLabel.text = todo.createDate.slashStyle
        
        buttonAction = action
    }
    
    private func configureUI() {
        applyStyles()
        setupLayout()
        setupCompletenessIndicator()
    }
    
    private func applyStyles() {
        titleLabel.cellTitleStyle()
        descriptionLabel.cellDescriptionStyle()
        createDateLabel.dateStyle()
        
        completenessIndicator.setBackgroundImage(.completed, for: .selected)
        completenessIndicator.setBackgroundImage(.uncompleted, for: .normal)
    }

    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, createDateLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 6
        
        completenessIndicator.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(completenessIndicator)
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            completenessIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            completenessIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            completenessIndicator.heightAnchor.constraint(equalTo: completenessIndicator.widthAnchor),
            completenessIndicator.widthAnchor.constraint(equalToConstant: 28),
            
            stack.leadingAnchor.constraint(equalTo: completenessIndicator.trailingAnchor, constant: 8),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    private func setupCompletenessIndicator() {
        completenessIndicator.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            self.completenessIndicator.isSelected.toggle()
            self.buttonAction?(self.completenessIndicator.isSelected)
        }, for: .touchUpInside)
    }
}
