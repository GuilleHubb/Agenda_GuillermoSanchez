
import Foundation
import UIKit


class ViewControllerMenu: UIViewController{
    
    
    @IBOutlet weak var saludo: UILabel!
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saludo.text = "Bienvenido, \(username)"
    }
    
}



