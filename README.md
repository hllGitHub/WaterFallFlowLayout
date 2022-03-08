# JHWaterFallFlowLayout

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* 使用 Swift
* iOS 11.0, Swift 4.0

## Example
![](https://tva1.sinaimg.cn/large/e6c9d24egy1h02kqkvzz0g209b0g9b2f.gif)
![](https://tva1.sinaimg.cn/large/e6c9d24egy1h02kpiuk1tj20hs0vkgql.jpg)
![](https://tva1.sinaimg.cn/large/e6c9d24egy1h02kq3y30dj20hs0vkaf8.jpg)

## Installation

JHWaterFallFlowLayout is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JHWaterFallFlowLayout'
```

## Usage

``` swift
// 引入 JHWaterFallFlowLayout 模块
import JHWaterFallFlowLayout

// 创建 WaterFallFlowLayout 实例，并且声明代理方法
private lazy var layout: WaterFallFlowLayout = {
  let layout = WaterFallFlowLayout()
  layout.delegate = self
  layout.minimumLineSpacing = 10
  layout.minimumInteritemSpacing = 10
  layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
  return layout
}()

// 创建 UICollectionView 实例，并且引用 layout 对象
private lazy var collectionView: UICollectionView = {
  let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
  collectionView.backgroundColor = .white
  collectionView.dataSource = self
  collectionView.showsVerticalScrollIndicator = false
  collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  collectionView.translatesAutoresizingMaskIntoConstraints = false
  collectionView.register(FlowCell.self, forCellWithReuseIdentifier: cellId)
  return collectionView
}()


// 实现 UICollectionViewDataSource
// 此处略，跟常规实现一致

// 实现 WaterFallFlowLayoutDelegate
// MARK: - WaterFallFlowLayoutDelegate
extension ViewController: WaterFallFlowLayoutDelegate {
  func waterFallFlowLayout(_ waterFallFlowLayout: WaterFallFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat {
    guard let image = datas[indexPath.item].thumbnail else {
      return 0.0
    }

    let imageWidth = waterFallFlowLayout.itemWidth
    let imageHeight = image.size.height * imageWidth / image.size.width

    print("\(indexPath.item) image height: \(imageHeight)")

    return imageHeight
  }

  func columnOfWaterFallFlow(in collectionView: UICollectionView) -> Int {
    return 2
  }
}
```

具体细节参考 Demo 实现。

## Author

liangliang.hu, hllfj922@gmail.com

## License

JHWaterFallFlowLayout is available under the MIT license. See the LICENSE file for more info.
