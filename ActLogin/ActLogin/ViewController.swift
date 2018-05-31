import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Nuevo Usuario", message: "Introduce tus datos por favor", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Guardar", style: .default) {
            action in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            FIRAuth.auth()!.createUser(withEmail: emailField.text!, password: passwordField.text!) {
                user, error in
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default)
        
        alert.addTextField { textEmail in textEmail.placeholder = "email" }
        alert.addTextField {
            textPassword in textPassword.isSecureTextEntry = true
            textPassword.placeholder = "contraseña"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        if self.loginEmailField.text == "" || self.loginPasswordField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Por favor introduce email y contraseña", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.loginEmailField.text!, password: self.loginPasswordField.text!) {
                
                (user, error) in
                
                if error == nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

