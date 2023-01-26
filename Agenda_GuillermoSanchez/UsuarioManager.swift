

import UIKit

class UsuarioManager: NSObject {
    
    static var listaDeUsuarios: [Usuario] = []
    
    static let urlUsuario: String = "https://superapi.netlify.app/api/db/users"
    
    static let urlLogin: String = "https://superapi.netlify.app/api/login"
    
    static let urlRegistro: String = "https://superapi.netlify.app/api/register"
    
    static func RecibirUsuarios(){
        
        var data = Data()
        
        let url = URL(string: urlUsuario)
        
        
        do{
            data = try Data(contentsOf: url!)
        }catch{
            print("No se han podido descargar los usuarios")
        }
        
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            var ListaTemporal: [Any] = []
            
            for i in json as! [Any]{
                if type(of: i) != NSNull.self{
                    ListaTemporal.append(i)
                }
            }
            
            for i in ListaTemporal as! [[String:Any]]{
                UsuarioManager.listaDeUsuarios.append(Usuario(json: i))
            }
            
        }catch{
            print("No se podido recibir los usuarios")
        }
        
        for i in UsuarioManager.listaDeUsuarios{
            print("Nombre:", i.nombre, "pass:", i.contrasena)
        }
    }
  
    static func CrearUsuario(parametros: [String:Any]) {
        
        let Parametros: [String:Any] = parametros
        
        let url = URL(string: UsuarioManager.urlRegistro)!
        
        let sesion = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Constant-Type")
        request.addValue("application/json", forHTTPHeaderField: "Acept")
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: Parametros, options: .prettyPrinted)
        }catch let error{
            print(error)
        }

        let tarea = sesion.dataTask(with: request){ data, response, error in
            
            if let error = error{
                print("error: ", error)
                return
            }
            
            if data != nil{
                UsuarioManager.RecibirUsuarios()
            }
            
        }
        tarea.resume()
    }
}
