

import UIKit


let url = URL(string: "")


class ViewController: UIViewController {
    @IBOutlet weak var NombreUsuario: UITextField!
    
    @IBOutlet weak var ContrasenaUsuario: UITextField!
    
    @IBOutlet weak var NombreUsuarioRegistro: UITextField!
    
    @IBOutlet weak var ContrasenaUsuarioRegistro: UITextField!
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){

           if segue.identifier == "IdIniciarSesion"{

               let destinationVC = segue.destination as? ViewControllerMenu


               destinationVC?.username = NombreUsuario.text!

           }

       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UsuarioManager.RecibirUsuarios()
        
    }
    
    
    @IBAction func IniciarSesion(_ sender: Any) {
        
        if !NombreUsuario.hasText && !ContrasenaUsuario.hasText{
            return
        }
        
        if !ComprobarContrasena(){
            return
        }
        
        performSegue(withIdentifier: "IdIniciarSesion", sender: sender)
    }
    
    func ComprobarContrasena() -> Bool{
        
        var correcto = false
        
        for i in UsuarioManager.listaDeUsuarios{
            
            if i.nombre == NombreUsuario.text!{
                
                if i.contrasena == ContrasenaUsuario.text!{
                    
                    correcto = true
                    
                }
                
            }
            
        }
        
        return correcto
        
    }
    
    
    @IBAction func RegistrarUsuario(_ sender: Any) {

        if !NombreUsuarioRegistro.hasText && !ContrasenaUsuarioRegistro.hasText{
            return
        }
        
        let parametros: [String:Any] = [
            "user" : NombreUsuarioRegistro.text!,
            "pass" : ContrasenaUsuarioRegistro.text!
        ]
        UsuarioManager.CrearUsuario(parametros: parametros)
    }
}

