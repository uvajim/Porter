import UIKit
import StripeTerminal
import StripePaymentSheet


class ReaderDiscoveryViewController: UIViewController, DiscoveryDelegate, LocalMobileReaderDelegate{
    func localMobileReader(_ reader: Reader, didStartInstallingUpdate update: ReaderSoftwareUpdate, cancelable: Cancelable?) {
        print("starting to install update")
    }
    
    func localMobileReader(_ reader: Reader, didReportReaderSoftwareUpdateProgress progress: Float) {
        print("reporting update progress")
    }
    
    func localMobileReader(_ reader: Reader, didFinishInstallingUpdate update: ReaderSoftwareUpdate?, error: Error?) {
        print("finished installing update")
    }
    
    func localMobileReader(_ reader: Reader, didRequestReaderInput inputOptions: ReaderInputOptions = []) {
        print("requested reader input")
    }
    
    func localMobileReader(_ reader: Reader, didRequestReaderDisplayMessage displayMessage: ReaderDisplayMessage) {
        print("requested to display message")
    }
    
    

    var discoverCancelable: Cancelable?

    // ...

    // Action for a "Discover Readers" button
    func discoverReadersAction() {
        let config = DiscoveryConfiguration(
          discoveryMethod: .localMobile,
          simulated: false
        )

        self.discoverCancelable = Terminal.shared.discoverReaders(config, delegate: self) { error in
            if let error = error {
                print("discoverReaders failed: \(error)")
            } else {
                print("discoverReaders succeeded")
            }
        }
    }

    // ...

    // MARK: DiscoveryDelegate

    func terminal(_ terminal: Terminal, didUpdateDiscoveredReaders readers: [Reader]) {
        // In your app, display the ability to use your phone as a reader
        // Call `connectLocalMobileReader` to initiate a session with the phone
        guard let selectedReader = readers.first else {return}
        
        let connectionConfig = LocalMobileConnectionConfiguration(locationId: "{{LOCATION_ID}}")
        Terminal.shared.connectLocalMobileReader(selectedReader, delegate: self, connectionConfig: connectionConfig) { reader, error in
            if let reader = reader {
                print("Successfully connected to reader: \(reader)")
            } else if let error = error {
                print("connectLocalMobileReader failed: \(error)")
            }
        }
    }
    
    func activateTerminal(){
        
    }
}




class SwiftStripeTerminalPlugin: LocalMobileReaderDelegate {
    
    init(){
        hash = 5
        description = "delegate"
    }
    
    func isEqual(_ object: Any?) -> Bool {
        return true
    }
    
    var hash: Int
    
    var superclass: AnyClass?
    
    func `self`() -> Self {
        return self
    }
    
    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        return Unmanaged.passRetained(UIColor.white.cgColor)
    }
    
    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
        return Unmanaged.passRetained(UIColor.white.cgColor)
    }
    
    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
        return Unmanaged.passRetained(UIColor.white.cgColor)
    }
    
    func isProxy() -> Bool {
        return true
    }
    
    func isKind(of aClass: AnyClass) -> Bool {
        return true
    }
    
    func isMember(of aClass: AnyClass) -> Bool {
        return true
    }
    
    func conforms(to aProtocol: Protocol) -> Bool {
        return true
    }
    
    func responds(to aSelector: Selector!) -> Bool {
        return true
    }
    
    var description: String
    
    func localMobileReader(_ reader: Reader, didRequestReaderInput inputOptions: ReaderInputOptions = []) {
        print("didRequestReaderInput: \(inputOptions)")
    }
    
    func localMobileReader(_ reader: Reader, didRequestReaderDisplayMessage displayMessage: ReaderDisplayMessage) {
        print("didRequestReaderDisplayMessage: \(displayMessage)")
    }
    
    func localMobileReader(_ reader: Reader, didFinishInstallingUpdate update: ReaderSoftwareUpdate?, error: Error?) {
        print("didStartInstallingUpdate")
    }

    func localMobileReader(_ reader: Reader, didReportReaderSoftwareUpdateProgress progress: Float) {
        print("didReportReaderSoftwareUpdateProgress")
    }

    func localMobileReader(_ reader: Reader, didStartInstallingUpdate update: ReaderSoftwareUpdate, cancelable: Cancelable?) {
        print("didFinishInstallingUpdate")
    }
}


class CheckoutViewController: UIViewController, ObservableObject {
    
    var secret : String?
    
     @Published var paymentSheet: PaymentSheet?
    
    
    
    func fetchPaymentSheet() {
        
        // start the API session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //attach which function we want to use
        let jsonBody = "{\"function\": \"3\"}"
        guard let url = URL(string: "https://6sqf7z7lqalemeowuzmgzeukcm0imgsw.lambda-url.us-east-1.on.aws") else {
            fatalError("Invalid backend URL")
        }
        var request = URLRequest(url: url)
        
        //set the options
        request.httpMethod = "POST"
        request.httpBody = jsonBody.data(using: .utf8)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data{
                do {
                    
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    else {
                        print("ERROR")
                        return
                        }
                    if let clientSecret = json["clientSecret"] as? String{
                        self.secret = clientSecret
                    }
                    else{
                        print("ERROR")
                        return
                    }
                    
                }
                
                catch{
                    print(error)
                }
            }
            else{
                print("ERROR")
                return
            }
            
        }
        task.resume()
        
        //
        
        // get the result.
        
        //set the token value
    }
    
    func checkout(){
        while self.secret == nil {}
        guard let intentSecret = self.secret else {
            return}
        print("break 1")
        var config = PaymentSheet.Configuration()
        config.merchantDisplayName = "22A4"
        config.applePay = .init(
            merchantId: "com.example.appname",
            merchantCountryCode: "US"
        )
        
        let paymentSheet = PaymentSheet(paymentIntentClientSecret: intentSecret, configuration: config)
        
        self.paymentSheet = paymentSheet
        }
    
    func pay() {
        self.fetchPaymentSheet()
        self.checkout()
    }


}


