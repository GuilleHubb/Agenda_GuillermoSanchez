

import UIKit

class Usuario: Decodable {
    var nombre: String
    var contrasena: String
    
    init(json: [String: Any]) {
        
        nombre = json["user"] as? String ?? ""
        
        contrasena = json["pass"] as? String ?? ""
        
    }
}
