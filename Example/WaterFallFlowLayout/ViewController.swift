  //
  //  ViewController.swift
  //  WaterFallFlowLayout
  //
  //  Created by liangliang.hu on 03/08/2022.
  //  Copyright (c) 2022 liangliang.hu. All rights reserved.
  //

import UIKit
import JHWaterFallFlowLayout
import Flickr

class ViewController: UIViewController {

  private let cellId = "cellId"
  private let margin: CGFloat = 10.0

  private lazy var layout: WaterFallFlowLayout = {
    let layout = WaterFallFlowLayout()
    layout.delegate = self
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
    return layout
  }()

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

  private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

  let flickr = Flickr()
  var datas: [FlickrPhoto] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(collectionView)
    requestData()
  }

  private func showLoading() {
    view.addSubview(activityIndicator)
    view.bringSubview(toFront: activityIndicator)
    activityIndicator.frame = view.bounds
    activityIndicator.startAnimating()
  }

  private func hideLoading() {
    activityIndicator.stopAnimating()
    activityIndicator.removeFromSuperview()
  }

  private func requestData(_ shouldShowLoading: Bool = true) {
    if shouldShowLoading {
      showLoading()
    }

    flickr.randomFlickr { [weak self] searchResults in
      guard let self = self else { return }
      DispatchQueue.main.async {
        if shouldShowLoading {
          self.hideLoading()
        }

        switch searchResults {
        case .failure(let error):
          print("Error Searching: \(error)")
        case .success(let results):
          print("""
            Found \(results.searchResults.count) \
            matching \(results.searchTerm)
          """)
          self.datas.append(contentsOf: results.searchResults)
          self.collectionView.reloadData()
        }
      }
    }
  }

  private func loadMore() {
    requestData(false)
  }

  func shouldLoadMore(datas: [FlickrPhoto], _ indexPath: IndexPath) -> Bool {
    return Double((datas.count - 1)) * 0.5 <= Double(indexPath.item)
  }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    datas.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FlowCell else {
      return UICollectionViewCell()
    }

    cell.setImage(image: datas[indexPath.item].thumbnail)
    if shouldLoadMore(datas: datas, indexPath) {
      loadMore()
    }

    return cell
  }
}

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
