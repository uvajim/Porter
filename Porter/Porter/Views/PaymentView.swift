//
//  PaymentView.swift
//  bazaari
//
//  Created by Jinming Liang on 3/4/23.
//

import SwiftUI
import StripeTerminal

struct PaymentView: View {
    @State var dollar_amount:Int = 0;
    @State var choose_dollars:Bool = true;
    @State var cent_amount:Int = 0;
    var discoverCancelable: Cancelable?
    
    let stripeController = ReaderDiscoveryViewController()

    
    var body: some View {
        VStack{
            HStack{
                if (choose_dollars){
                    Text(String(dollar_amount))
                    .font(.system(size: 45))
                }
                else{
                    var updated_amount = dollar_amount
                    Text(String(updated_amount) + "." + String(cent_amount))
                    .font(.system(size: 45))
                }
            }.padding()
            HStack{
                Button( action: {
                    if (choose_dollars){
                        dollar_amount = dollar_amount * 10 + 1
                    }
                    else{
                        if (cent_amount * 10 > 100) {}
                        else{
                            cent_amount = cent_amount * 10 + 1
                        }
                    }
                        
                }){
                    Text("1")
                    .font(.system(size: 45))
                    .frame(width: 100)
                }
                Button( action: {
                    if (choose_dollars){
                        dollar_amount = dollar_amount * 10 + 2
                    }
                    else{
                        if (cent_amount * 10 > 100) {}
                        else{
                            cent_amount = cent_amount * 10 + 2
                        }
                    }
                    }
                ){
                    Text("2")
                    .font(.system(size: 45))
                    .frame(width: 100)
                }
                Button( action: {
                    if (choose_dollars){
                        dollar_amount = dollar_amount * 10 + 3
                    }
                    else{
                        if (cent_amount * 10 > 100) {}
                        else{
                            cent_amount = cent_amount * 10 + 3
                        }
                    }
                }){
                    Text("3")
                    .font(.system(size: 45))
                    .frame(width: 100)
                }
            }
            HStack{
                Button( action: {
                    if (choose_dollars){
                        dollar_amount = dollar_amount * 10 + 4
                    }
                    else{
                        if (cent_amount * 10 > 100) {}
                        else{
                            cent_amount = cent_amount * 10 + 4
                        }
                    }
                }){
                    Text("4")
                    .font(.system(size: 45))
                    .frame(width: 100)
                }
                Button( action: { if (choose_dollars){
                    dollar_amount = dollar_amount * 10 + 5
                }
                else{
                    if (cent_amount * 10 > 100) {}
                    else{
                        cent_amount = cent_amount * 10 + 5
                    }
                }}){
                    Text("5")
                    .font(.system(size: 45))
                    .frame(width: 100)
                }
                Button( action: { if (choose_dollars){
                    dollar_amount = dollar_amount * 10 + 6
                }
                else{
                    if (cent_amount * 10 > 100) {}
                    else{
                        cent_amount = cent_amount * 10 + 6
                    }
                }}){
                    Text("6")
                    .font(.system(size: 45))
                    .frame(width: 100)
                }
            }
            .padding()
            HStack{
                Button( action: {
                    if (choose_dollars){
                        dollar_amount = dollar_amount * 10 + 7
                    }
                    else{
                        if (cent_amount * 10 > 100) {}
                        else{
                            cent_amount = cent_amount * 10 + 7
                        }
                        
                    }
                }){
                    Text("7")
                        .font(.system(size: 45))
                        .frame(width: 100)
                }
                Button( action: {
                    if (choose_dollars){
                        dollar_amount = dollar_amount * 10 + 8
                    }
                    else{
                        if (cent_amount * 10 > 100) {}
                        else{
                            cent_amount = cent_amount * 10 + 8
                        }
                    }
                }){
                    Text("8")
                        .font(.system(size: 45))
                        .frame(width: 100)
                }
                Button( action: {
                    if (choose_dollars){
                        dollar_amount = dollar_amount * 10 + 9
                    }
                    else{
                        if (cent_amount * 10 > 100) {}
                        else{
                            cent_amount = cent_amount * 10 + 9
                        }
                    }
                }){
                    Text("9")
                        .font(.system(size: 45))
                        .frame(width: 100)
                }
            }
            .padding()
                    HStack{
                        Button( action: {
                            dollar_amount = 0
                            cent_amount = 0
                            choose_dollars = true
                        }){
                            Text("DEL")
                            .font(.system(size: 45))
                            .frame(width: 100)
                        }
                        Button( action: {
                            if (choose_dollars){
                                dollar_amount = dollar_amount * 10
                            }
                            else{
                                if (cent_amount * 10 > 100) {}
                                else{
                                    cent_amount = cent_amount * 10
                                }
                            }
                        }){
                            Text("0")
                            .font(.system(size: 45))
                            .frame(width: 100)
                        }
                        Button( action: {
                            if (choose_dollars){
                                choose_dollars.toggle()
                            }
                            
                        }){
                            Text(".")
                            .font(.system(size: 45))
                            .frame(width: 100)
                        }
                    }.padding()
            Button("Tender"){stripeController.discoverReadersAction()}.font(.system(size: 36)).frame(maxWidth: .infinity).buttonStyle(.borderedProminent)
            
        }
    }
    
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}

