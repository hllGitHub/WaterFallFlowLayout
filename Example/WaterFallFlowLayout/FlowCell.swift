//
//  FlowCell.swift
//  WaterFallFlowLayout_Example
//
//  Created by liangliang hu on 2022/3/8.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class FlowCell: UICollectionViewCell {
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setImage(image: UIImage?) {
    imageView.image = image
  }

  private func setupUI() {
    contentView.addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
    ])
  }
}
