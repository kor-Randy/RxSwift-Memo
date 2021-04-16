//
//  MemoComposeViewController.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import Action
import RxCocoa
import RxSwift
import UIKit

class MemoComposeViewController: UIViewController, ViewModelBindableType {
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var contentTextView: UITextView!
    
    let bag = DisposeBag()
    
    var viewModel: MemoComposeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
    
    func bindViewModel() {
        viewModel.title.drive(navigationItem.rx.title)
            .disposed(by: bag)
        
        viewModel.initialText
            .drive(contentTextView.rx.text)
            .disposed(by: bag)
        
        cancelButton.rx.action = viewModel.cancelAction
        
        saveButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: bag)
    }
}
