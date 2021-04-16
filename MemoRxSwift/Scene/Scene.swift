//
//  Scene.swift
//  MemoRxSwift
//
//  Created by 지현우 on 2021/04/15.
//

import UIKit

enum Scene{
    case list(MemoListViewModel)
    case datail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

extension Scene{
    func instantiate(from storyboard: String = "Main") -> UIViewController{
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .list(let viewModel):
            guard let nav = sb.instantiateViewController(withIdentifier: "ListNavigation") as? UINavigationController else {
                fatalError()
            }
            guard var listVC = nav.viewControllers.first as? MemoListViewController else {
                fatalError()
            }
            
            listVC.bind(viewModel: viewModel)
            return nav
            
        case .datail(let viewModel):
            guard var detailVC = sb.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else {
                fatalError()
            }
            
            detailVC.bind(viewModel: viewModel)
            return detailVC
            
        case .compose(let viewModel):
            guard let nav = sb.instantiateViewController(withIdentifier: "ComposeNavigation") as? UINavigationController else {
                fatalError()
            }
            
            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else {
                fatalError()
            }
            
            composeVC.bind(viewModel: viewModel)
            return nav
        }
    }
}
