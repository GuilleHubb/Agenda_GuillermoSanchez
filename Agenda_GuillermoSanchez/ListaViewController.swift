
import Foundation

import UIKit

class ListaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventosManager.ListaEventos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! Celda
        
        Celda.NombreEvento.text = EventosManager.ListaEventos[indexPath.row].Nombre
        
        
        let nuevoTiempo = TimeInterval(EventosManager.ListaEventos[indexPath.row].Date / 1000)

        let fechaNueva = Date(timeIntervalSince1970: nuevoTiempo)
        
        Celda.FechaEvento.text = fechaNueva.formatted().description
       
        
        return Celda
        
        
    }
    
    
    @IBOutlet weak var ListaEventos: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        EventosManager.DescargarEventos()

        ListaEventos.delegate = self
        ListaEventos.dataSource = self

    }


    

    

}


