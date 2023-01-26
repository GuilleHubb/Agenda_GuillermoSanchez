
import Foundation
import UIKit


class CrearEvento: UIViewController{
    
    guard let url = URL(string: "https://superapi.netlify.app/api/db/eventos") else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
    
    request.httpBody = httpBody
    
    let session = URLSession.shared
    //usar Data URLRequest
    session.dataTask(with: request ) { (data, response, error) in
        
        if let response = response {
            print(response)
        }
        
        if let data = data {
            do {
                //Elegimos jsonObject InputStream
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
            catch{
                print(error)
            }
        }
        
    }.resume()
}




