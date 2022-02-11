//
//  GlobalFunctions.swift
//  IngeniousLabAssessment
//
//  Created by Ban Er Win on 10/02/2022.
//

import Foundation
import UIKit

func showWarning(msg: String, vc: UIViewController) {
    let alert = UIAlertController(title: "Inglab Assessment", message: msg, preferredStyle: UIAlertController.Style.alert);
    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    vc.present(alert, animated: true, completion: nil)
}
