//
//  Evento.swift
//  Agenda_GuillermoSanchez
//
//  Created by Apps2M on 24/1/23.
//

import UIKit

class Evento: Decodable {

    var Nombre: String
    var Date: Double

    init(json: [String:Any]){
        Nombre = json["name"] as? String ?? ""
        Date = json["date"] as? Double ?? 0
    }
}
