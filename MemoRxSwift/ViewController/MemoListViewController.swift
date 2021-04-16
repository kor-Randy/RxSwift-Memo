//
//  MemoListViewController.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import UIKit
import RxCocoa
import RxSwift

class MemoListViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MemoListViewModel!

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
        
        viewModel.memoList
            .bind(to: listTableView.rx.items(cellIdentifier: "MemoCell")){ row, memo, cell in
                cell.textLabel?.text = memo.content
            }
            .disposed(by: bag)
        
        addButton.rx.action = viewModel.makeCreateAction()
    }

}
