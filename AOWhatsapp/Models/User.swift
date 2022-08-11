//
//  User.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 10/08/22.
//

import Foundation
import UIKit

struct User {
    let id: Int
    let name: String
    let image: String
    let messages: [Message]?
}
