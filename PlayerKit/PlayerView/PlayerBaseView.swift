//
// Created by majiancheng on 2018/5/24.
// Copyright (c) 2018 majiancheng. All rights reserved.
//

import Foundation

open class PlayerBaseView: UIView {
    var contentView: UIView!
    var drawView: UIView!
    var controlContentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareUI()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open func prepareUI() {
        self.contentView = UIView(frame: self.bounds)
        self.addSubview(self.contentView)

        self.drawView = UIView(frame: self.contentView.frame)
        self.controlContentView = UIView(frame: self.contentView.bounds)
        self.addSubview(self.drawView)
        self.addSubview(self.contentView)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        self.contentView.frame = self.bounds
        self.drawView.frame = self.contentView.bounds
        self.controlContentView.frame = self.contentView.bounds
    }
}
