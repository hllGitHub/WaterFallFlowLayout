# JHWaterFallFlowLayout

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* 使用 Swift
* iOS 11.0, Swift 4.0

## Example
![waterflowlayout_example](https://user-images.githubusercontent.com/15081858/157207305-b0ce59a2-b945-4675-803c-c9094d77b1c1.gif)


![waterflowlayout_example01](https://user-images.githubusercontent.com/15081858/157207404-b25d4ee8-eb1b-4192-b5be-f6d9ee15e5d7.png)
![waterflowlayout_example02](https://user-images.githubusercontent.com/15081858/157207424-0b5d15e5-2a39-4e04-9c0d-534627e72906.png)


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
