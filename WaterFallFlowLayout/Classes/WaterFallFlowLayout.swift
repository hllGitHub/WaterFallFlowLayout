//
//  WaterFallFlowLayout.swift
//  WaterFallLayout
//
//  Created by liangliang hu on 2022/3/8.
//

import UIKit

public protocol WaterFallFlowLayoutDelegate: NSObjectProtocol {
  func waterFallFlowLayout(_ waterFallFlowLayout: WaterFallFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat

  func columnOfWaterFallFlow(in collectionView: UICollectionView) -> Int
}

public class WaterFallFlowLayout: UICollectionViewFlowLayout {
  public weak var delegate: WaterFallFlowLayoutDelegate?

  // item 宽度
  public var itemWidth: CGFloat = 10.0

  fileprivate let defaultColumn = 2

  fileprivate var columns: Int {
    guard let collectionView = collectionView else { return defaultColumn }
    return delegate?.columnOfWaterFallFlow(in: collectionView) ?? defaultColumn
  }

  // 布局数组
  fileprivate lazy var layoutAttributes: [UICollectionViewLayoutAttributes] = []
  // 高度数组
  fileprivate lazy var heights: [CGFloat] = Array(repeating: self.sectionInset.top, count: columns)
  // 最大高度
  fileprivate lazy var maxHeight: CGFloat = 0.0

  public override func prepare() {
    super.prepare()

    // 清除缓存数据
    layoutAttributes = []
    heights = Array(repeating: self.sectionInset.top, count: columns)

    guard let collectionView = collectionView else { return }

    let itemWidth = (collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(columns - 1)) / CGFloat(columns)
    self.itemWidth = itemWidth
    let itemCount = collectionView.numberOfItems(inSection: 0)
    // 最小高度索引
    var minHeightIndex = 0

    // 遍历 item 计算并缓存属性
    for i in layoutAttributes.count ..< itemCount {
      let indexPath = IndexPath(item: i, section: 0)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      // 获取动态高度
      let itemHeight = delegate?.waterFallFlowLayout(self, itemHeight: indexPath)

      // 找到高度最短的那一列
      if let value = heights.min() {
        minHeightIndex = heights.firstIndex(of: value) ?? 0
      }
      // 获取该列的 Y 坐标
      var itemmY = heights[minHeightIndex]
      if i >= columns {
        itemmY += minimumLineSpacing
      }

      // 计算该索引的 X 坐标
      let itemX = sectionInset.left + (itemWidth + minimumInteritemSpacing) * CGFloat(minHeightIndex)
      // 赋值新的位置信息
      attributes.frame = CGRect(x: itemX, y: itemmY, width: itemWidth, height: CGFloat(itemHeight ?? 0.0))
      // 缓存布局属性
      layoutAttributes.append(attributes)
      heights[minHeightIndex] = attributes.frame.maxY
    }
    maxHeight = heights.max() ?? 0 + sectionInset.bottom
  }
}

extension WaterFallFlowLayout {
  public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return layoutAttributes.filter { $0.frame.intersects(rect) }
  }

  public override var collectionViewContentSize: CGSize {
    guard let collectionView = collectionView else { return .zero }
    return CGSize(width: collectionView.bounds.width, height: maxHeight)
  }
}
