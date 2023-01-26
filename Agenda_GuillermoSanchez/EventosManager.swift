

import UIKit

class EventosManager: NSObject {

    static var ListaEventos: [Evento] = []
    
    static let URLEventos: String = "https://superapi.netlify.app/api/db/eventos"

  static func DescargarEventos(){
      let url = URL(string: URLEventos)
        
        var data = Data()
        
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
                
                //let fecha: String = Evento(json: i).
                EventosManager.ListaEventos.append(Evento(json: i))
            }
            
        }catch{
            print("No se podido recibir los usuarios")
        }
        
    }

}
