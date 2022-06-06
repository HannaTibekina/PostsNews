//
//  TableViewCell.swift
//  PostsNew
//
//  Created by Анна Тибекина on 21.03.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var contantContainer: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var showMoreButtonView: UIView!
    
    @IBOutlet weak var showMoewButton: UIButton!
    
    @IBOutlet weak var additionalInfoView: UIView!
    
    @IBOutlet weak var likesIcon: UIImageView!
    
    @IBOutlet weak var likesCount: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var containerTopOffset: NSLayoutConstraint!
    
    @IBOutlet weak var containerBottomOffset: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContent()
        clearContent()
    }
    
    func setupContent() {
        backgroundColor = .clear
        showMoewButton.backgroundColor = .systemPurple
        showMoewButton.setTitleColor(.white, for: .normal)
        showMoewButton.setTitleColor(.white.withAlphaComponent(0.5), for: .highlighted)
        selectedBackgroundView = UIView()
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            selectedBackgroundView?.backgroundColor = .secondarySystemBackground
            contantContainer.backgroundColor = .tertiarySystemBackground.withAlphaComponent(0.5)
        } else {
            selectedBackgroundView?.backgroundColor = .secondarySystemBackground
            contantContainer.backgroundColor = .tertiarySystemBackground
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearContent()
    }
    
    func clearContent() {
        titleLabel.text = nil
        subtitleLabel.text = nil
        likesCount.text = nil
        dateLabel.text = nil
        containerTopOffset.constant = 0
        containerBottomOffset.constant = 15
    }
    
}
