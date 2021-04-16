//
//  MemoDatailViewController.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import UIKit
import RxSwift
import RxCocoa

class MemoDetailViewController: UIViewController, ViewModelBindableType{

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
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
            .bind(to: listTableView.rx.items){ tableView, row, value in
                switch row{
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell")!
                    cell.textLabel?.text = value
                    return cell
                case .1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell")!
                    cell.textLabel?.text = value
                    return cell
                    
                default:
                    fatalError()
                }
            }
            .disposed(by: bag)
    }
    
}
