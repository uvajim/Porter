//
//  PlaidController.swift
//  Porter
//
//  Created by Jinming Liang on 3/16/23.
//

import Foundation
import LinkKit
import SwiftUI

class PlaidController: ObservableObject{
    
    var linkToken : String?
    
    init(){
        self.fetchLinkToken()
    }
     
    func fetchLinkToken() {
        
        
        // start the API session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //attach which function we want to use
        let jsonBody = "{\"function\": \"1\"}"
        guard let url = URL(string: "https://mtrggon3juerx5cli5d6j6hwse0zqtgl.lambda-url.us-east-1.on.aws/") else {
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
                    if let linkToken = json["link_token"] as? String{
                        print("LINK TOKEN: \(linkToken)")
                        self.linkToken = linkToken
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
    
    func createLinkTokenConfiguration() -> LinkTokenConfiguration {
        
        while linkToken == nil {}

        // With custom configuration using a link_token
        var linkConfiguration = LinkTokenConfiguration(token: self.linkToken!) { success in
            print("public-token: \(success.publicToken) metadata: \(success.metadata)")
        }
        
        linkConfiguration.onExit = { exit in
            if let error = exit.error {
                print("exit with \(error)\n\(exit.metadata)")
            } else {
                print("exit with \(exit.metadata)")
            }
        }

        linkConfiguration.onEvent = { event in
            print("Link Event: \(event)")
        }

        return linkConfiguration
    }
}


struct OpenLinkButton: View {
    static let color = Color(
        red: 0,
        green: 191 / 256,
        blue: 250 / 256,
        opacity: 1
    )

    @State private var showLink = false
    
    private let plaidController = PlaidController()

    #warning("Replace <#GENERATED_LINK_TOKEN#> below with your link_token")
    var body: some View {
        Button(action: {
            self.showLink = true
        }) {
            Text("Open Plaid Link")
                .font(.system(size: 17, weight: .medium))
        }
        .padding()
        .foregroundColor(.white)
        .background(
            Self.color
                .frame(width: 1000, height: 1000)
        )
        .cornerRadius(4)
        .sheet(isPresented: self.$showLink,
            onDismiss: {
                self.showLink = false
            }, content: {
                PlaidLinkFlow(
                    linkTokenConfiguration: createLinkTokenConfiguration(),
                    showLink: $showLink
                )
            }
        )
    }

    private func createLinkTokenConfiguration() -> LinkTokenConfiguration {
        var configuration = LinkTokenConfiguration(
            token: plaidController.linkToken!,
            onSuccess: { success in
                print("public-token: \(success.publicToken) metadata: \(success.metadata)")
                showLink = false
            }
        )

        configuration.onEvent = { event in
            print("Link Event: \(event)")
        }

        configuration.onExit = { exit in
            if let error = exit.error {
                print("exit with \(error)\n\(exit.metadata)")
            } else {
                print("exit with \(exit.metadata)")
            }
            
            showLink = false
        }

        return configuration
    }
}

private struct PlaidLinkFlow: View {
    @Binding var showLink: Bool
    private let linkTokenConfiguration: LinkTokenConfiguration

    init(linkTokenConfiguration: LinkTokenConfiguration, showLink: Binding<Bool>) {
        self.linkTokenConfiguration = linkTokenConfiguration
        self._showLink = showLink
    }

    var body: some View {
        let linkController = LinkController(
            configuration: .linkToken(linkTokenConfiguration)
        ) { createError in
            print("Link Creation Error: \(createError)")
            self.showLink = false
        }

        return linkController
            .onOpenURL { url in
                linkController.linkHandler?.continue(from: url)
            }
    }
}



