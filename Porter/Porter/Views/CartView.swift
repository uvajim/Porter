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
    
    init(){
        stripePayment.pay()
        StripeAPI.defaultPublishableKey = "pk_test_51MFUYkGUGzYa5sOr37A8u6F0QwM4FbHuENSgyBCf9Vm1J3dVy4zz4zVpYqmPojr6ITmrboaYykRHOS87PeOIRzOQ00SFoQyIYE"
    }
    
    
    
    
    var body: some View {
        VStack{
            PaymentSheet.PaymentButton(paymentSheet: stripePayment.paymentSheet!, onCompletion: {_ in print("Success")}, content: {Text("Checkout")})
            }
        }
        }




struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
