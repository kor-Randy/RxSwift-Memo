//
//  MemoDatailViewController.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import RxCocoa
import RxSwift
import UIKit

class MemoDetailViewController: UIViewController, ViewModelBindableType {
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var deleteButton: UIBarButtonItem!
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var shareButton: UIBarButtonItem!
    
    var viewModel: MemoDetailViewModel!
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
        
        viewModel.contents
            .bind(to: listTableView.rx.items) { tableView, row, value in
                switch row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell")!
                    cell.textLabel?.text = value
                    return cell
                    
                default:
                    fatalError()
                }
            }
            .disposed(by: bag)
        
        //Action VS Tap 어떤 차이가 있는가?
        editButton.rx.action = viewModel.makeEditAction()
        
        deleteButton.rx.action = viewModel.makeDeleteAction()
        
        shareButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let memo = self?.viewModel.memo.content else { return }
                
                let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
                self?.present(vc, animated: true, completion: nil)
            })
            .disposed(by: bag)
    }
}
