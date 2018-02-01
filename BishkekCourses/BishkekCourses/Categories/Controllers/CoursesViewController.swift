//
//  CoursesViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/4/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import PullToRefreshKit
import RxSwift
import RxCocoa
import Moya
class CoursesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var subcategory_id = 0
    var insets: CGFloat = 12
    let disposeBag = DisposeBag()
    var courses: Variable<[SimpleCourse]> = Variable([])
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            insets = 24
        }
        setNavigationBarItems()
        configureCollectionView()
        getData()
        bindCollectionView()
        bindCollectionViewSelected()
        
    }
    func getData() {
        ServerAPIManager.sharedAPI.getCoursesBySubcategory(subcategory_id: self.subcategory_id, setCourses, showError: showErrorAlert)
    }
    func bindCollectionView(){
        courses.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "CoursesCollectionViewCell", cellType: CoursesCollectionViewCell.self)) { row, element, cell in
            cell.fillCell(course: element)
            }.disposed(by: disposeBag)
    }
    func bindCollectionViewSelected() {
        collectionView.rx.modelSelected(SimpleCourse.self).subscribe(onNext: {[weak self] element in
            guard let strongSelf = self else {return}
            let storyboard = UIStoryboard.init(name: "Course", bundle: nil)
            let courseVC = storyboard.instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
            courseVC.course_id = element.id
            strongSelf.navigationController?.show(courseVC, sender: self)
            
        }).disposed(by: disposeBag)
    }
    func setCourses(courses: [SimpleCourse]){
        self.courses.value = courses
        self.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Курсы"
        print("CoursesViewController resources: \(RxSwift.Resources.total)")
    }
    deinit {
        print("deinit CoursesViewController resources: \(RxSwift.Resources.total)")
    }
}

extension CoursesViewController {
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "CoursesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoursesCollectionViewCell")
        collectionView?.contentInset = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
        collectionView.rx.setDelegate(self as UIScrollViewDelegate).disposed(by: disposeBag)
        let header = DefaultRefreshHeader.header()
        header.setText(Constants.Hint.Refresh.pull_to_refresh, mode: .pullToRefresh)
        header.setText(Constants.Hint.Refresh.relase_to_refresh, mode: .releaseToRefresh)
        header.setText(Constants.Hint.Refresh.success, mode: .refreshSuccess)
        header.setText(Constants.Hint.Refresh.refreshing, mode: .refreshing)
        header.setText(Constants.Hint.Refresh.failed, mode: .refreshFailure)
        header.imageRenderingWithTintColor = true
        header.durationWhenHide = 0.4
        collectionView.configRefreshHeader(with: header, action: { [weak self] in
            self?.getData()
        })
        
    }
}
extension CoursesViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        return CGSize(width: itemSize, height: itemSize / 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insets
    }
}

