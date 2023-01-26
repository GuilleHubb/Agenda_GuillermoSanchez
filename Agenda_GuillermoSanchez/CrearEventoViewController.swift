

import Foundation
import UIKit

class CrearEventoViewController: UIViewController {
    let dataManager : DataManager = DataManager()
    
   

    
    @IBOutlet weak var crearEvento: UITextField!
  
    @IBOutlet weak var dateFecha: UIDatePicker!
    
    struct ResponseObject<T: Decodable>: Decodable {
        let form: T
    }
    
    @IBAction func botonSubir(_ sender: Any) {
       
        
        let newEvent : String = crearEvento.text!
        let newDate = Int(dateFecha.date.timeIntervalSince1970 * 1000)
        
        
        let url = URL(string: "https://superapi.netlify.app/api/db/eventos")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let postEvent: [String : Any] = [
            "date" : newDate,
            "name" : newEvent
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postEvent, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {                                                               // comprobar si hay un error fundamental en la red
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // comprueba si hay errores http.
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            // haz lo que quieras con los `datos`, p.ej:
            
            do {
                let responseObject = try JSONDecoder().decode(ResponseObject<Evento>.self, from: data)
                print(responseObject)
            } catch {
                print(error) // error de análisis
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }
        
        task.resume()
        
        
    }
    
}

