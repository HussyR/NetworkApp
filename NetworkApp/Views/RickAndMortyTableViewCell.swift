//
//  RickAndMortyTableViewCell.swift
//  NetworkApp
//
//  Created by Данил on 03.02.2022.
//

import UIKit

class RickAndMortyTableViewCell: UITableViewCell {

    var cellModel : Character?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Чтобы картинки в таблице не дублировались
        characterImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    //MARK: SetupUI
    private func setupUI() {
        addSubview(characterImageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor),
            
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 6)
        ])
        
        backCircleView.addSubview(circle)
        backCircleView.addSubview(aliveStatusLabel)
        
        NSLayoutConstraint.activate([
            backCircleView.heightAnchor.constraint(equalToConstant: 28),
            
            circle.leadingAnchor.constraint(equalTo: backCircleView.leadingAnchor),
            circle.topAnchor.constraint(equalTo: backCircleView.topAnchor, constant: 8),
            circle.bottomAnchor.constraint(equalTo: backCircleView.bottomAnchor, constant: -8),
            circle.widthAnchor.constraint(equalTo: circle.heightAnchor),
            
            aliveStatusLabel.centerYAnchor.constraint(equalTo: backCircleView.centerYAnchor),
            aliveStatusLabel.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 8)
        ])
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(backCircleView)
        stackView.addArrangedSubview(lastLocationLabel)
        stackView.addArrangedSubview(planetLabel)
    }
    
    //MARK: Cell configuration
    func configureCell() {
        guard let model = cellModel else {return}
        nameLabel.text = model.name
        // FIXME: Переделать на enum, не закладывать на строку
        if (model.status == "Alive") {
            circle.backgroundColor = .green
        } else {
            circle.backgroundColor = .red
        }
        aliveStatusLabel.text = model.status + " - " + model.species
        planetLabel.text = model.location.name
        let imageURL = model.image
        NetworkManager.fetchImage(url: model.image) { [weak self] data in
            guard let self = self,
                  let image = UIImage(data: data)
            else {return}
            DispatchQueue.main.async {
                if (imageURL == model.image) {
                    self.characterImageView.image = image
                }
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI elemenets
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let aliveStatusLabel : UILabel = {
        let label = UILabel()
        label.text = "alive"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let circle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        return view
    }()
    
    let lastLocationLabel : UILabel = {
        let label = UILabel()
        label.text = "Last known location:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let planetLabel : UILabel = {
        let label = UILabel()
        label.text = "Earth"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let characterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
//        imageView.backgroundColor = .brown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
