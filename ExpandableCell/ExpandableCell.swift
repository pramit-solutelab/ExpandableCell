//
//  ExpandableCell.swift
//  ExpandableCell
//
//  Created by Seungyoun Yi on 2017. 8. 10..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

open class ExpandableCell: UITableViewCell {
    open var arrowImageView: UIImageView!
    open var lblLineView: UILabel!
    open var rightMargin: CGFloat = 26
    open var highlightAnimation = HighlightAnimation.animated
    private var isOpen = false
    private var initialExpansionAllowed = true

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    func initView() {
        arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named:"dropdownheader")
        lblLineView = UILabel()
        lblLineView.backgroundColor = UIColor.init(red: 202/255, green: 238/255, blue: 240/255, alpha: 1.0)
        self.contentView.addSubview(arrowImageView)
        self.contentView.addSubview(lblLineView)
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.bounds.width
        _ = self.bounds.height
        arrowImageView.frame = CGRect(x: width - rightMargin, y: 21,width: 9.33, height: 5.33)
        lblLineView.frame = CGRect(x: 10, y: 68, width: width - 20, height: 1)
    }
    func open() {
        self.isOpen = true
        self.initialExpansionAllowed = false
       
        if highlightAnimation == .animated {
            UIView.animate(withDuration: 0.3) {[weak self] in
                self?.lblLineView.backgroundColor = .clear
                self?.arrowImageView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 1.0, 0.0, 0.0)
            }
        }
    }

    func close() {
        self.isOpen = false
       
        if highlightAnimation == .animated {
            UIView.animate(withDuration: 0.3) {[weak self] in
                self?.lblLineView.backgroundColor = UIColor.init(red: 202/255, green: 238/255, blue: 240/255, alpha: 1.0)
                self?.arrowImageView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0.0, 0.0, 0.0)
            }
        }
    }
    
    func isInitiallyExpandedInternal() -> Bool {
        return self.initialExpansionAllowed && self.isInitiallyExpanded()
    }

    open func isExpanded() -> Bool {
        return isOpen
    }
    
    open func isInitiallyExpanded() -> Bool {
        return false
    }
    
    open func isSelectable() -> Bool {
        return false
    }
}

public enum HighlightAnimation {
    case animated
    case none
}

