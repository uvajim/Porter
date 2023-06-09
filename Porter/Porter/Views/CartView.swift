//
//  CartView.swift
//  Porter
//
//  Created by Jinming Liang on 3/14/23.
//

import SwiftUI
import StripePaymentSheet

struct CartView: View {
    
    private var secret = ""
    
    @ObservedObject var stripePayment = CheckoutViewController()
    
    @State var checkoutFinishedLoading = false
    
    var body: some View {
        VStack {
            if stripePayment.paymentSheet != nil{
                        PaymentSheet.PaymentButton(paymentSheet: stripePayment.paymentSheet!, onCompletion: { result in
                            print("Success")
                            // modify self properties here
                        }, content: { Text("Checkout") })
                    } else {
                        ProgressView()
                    }
        }.onAppear(perform: {
            
        }).task {
            StripeAPI.defaultPublishableKey = "pk_test_51MFUYkGUGzYa5sOr37A8u6F0QwM4FbHuENSgyBCf9Vm1J3dVy4zz4zVpYqmPojr6ITmrboaYykRHOS87PeOIRzOQ00SFoQyIYE"
                    do{
                        stripePayment.paymentSheet = try await stripePayment.checkout()
                    }
                    catch{
                        print("bad checkout")
                    }
            
            checkoutFinishedLoading = true
        }
        }
        }




struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        Text("wip")
    }
}
