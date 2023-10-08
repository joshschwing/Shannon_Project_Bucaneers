//
//  ContentView.swift
//  Shannon Health Sync
//
//  Created by Joshua Schwing on 9/30/23.
//

import SwiftUI

struct ContentView: View {
    // variables
    @State private var username = ""
    @State private var password = ""
    @State private var validLogin = false
    
    var body: some View {
        //NavigationView{
            VStack {
                NavigationStack{
                    Text("Welcome to Shannon Health Sync!")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                        //.offset(y: -60)
                    Image("Clover")
                        .padding([.leading, .bottom, .trailing])
                        //.offset(y: -80)
                    Spacer()
                        .frame(height: 100.0)
                    Text("Please Login to Your Shannon Health Sync Account")
                        .multilineTextAlignment(.center)
                        .padding(.all)
                        //.offset(y: -80)
                    TextField("Patient ID", text: $username)
                        .padding()
                        .frame(width: 300.0, height: 50.0)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(5)
                        //.offset(y: -80)
                    SecureField(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/"Password"/*@END_MENU_TOKEN@*/, text: $password)
                        .padding()
                        .frame(width: 300.0, height: 50.0)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(5)
                        //.offset(y: -80)
                    NavigationLink(destination: loginDestination,
                        label: {Text("Login")
                            .padding()
                            .frame(width: 100.0, height: 50.0)
                            .background(Color.green)
                            .cornerRadius(15)
                            //.offset(y: -80)
                        //EmptyView()
                    }
                    )
                }
                .onTapGesture {
                    if username != "" && password != "" {
                        validLogin = true
                        //print("validLogin set to true")
                        } else {
                        validLogin = false
                        //print("validLogin set to false")
                        }
                }
            }
        //}
    }
    var loginDestination: some View {
            if validLogin {
                //print("Login success")
                return AnyView(loginSuccess())
            } else {
                //print("Login failed")
                return AnyView(loginFail())
            }
        }
    
    struct loginSuccess: View {
        var body: some View {
            VStack {
                Text("Login success!")
            }
        }
        
    }
    
    struct loginFail: View {
        var body: some View {
            VStack {
                Text("Login failed, please try again")
            }
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
