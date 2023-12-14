//
//  ContentView.swift
//  Shannon Health Sync
//
//  Created by Adian Acosta on 12/10/23.
//

import SwiftUI
import HealthKit
import Firebase

struct ContentView: View {
    // variables
    @State private var username = ""
    @State private var password = ""
    @State private var validLogin = false
    @State private var userLogged = false
    @State private var healthStore = HKHealthStore()
    
    var body: some View {
        //NavigationView{
        if userLogged { // If the user is logged in, show the ListView. This is where the main meat of the application runs
            ListView()
        } else {
            // If the user is not logged in, show the content page (AKA, spit back to login screen)
            content
        }
    }
    
    var content: some View {
        VStack {
            NavigationStack{
                // app title and login IU
                Text("Welcome to Shannon Health Sync!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                    //.offset(y: -60)
                // Shannon logo
                Image("Clover")
                    .padding([.leading, .bottom, .trailing])
                    //.offset(y: -80)
                Spacer()
                    .frame(height: 100.0)
                Text("Please Login to Your Shannon Health Sync Account")
                    .multilineTextAlignment(.center)
                    .padding(.all)
                    //.offset(y: -80)
                // email text box
                TextField("Email", text: $username)
                    .padding()
                    .frame(width: 300.0, height: 50.0)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(5)
                    //.offset(y: -80)
                // password text box
                SecureField(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/"Password"/*@END_MENU_TOKEN@*/, text: $password)
                    .padding()
                    .frame(width: 300.0, height: 50.0)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(5)
                    //.offset(y: -80)
                // old test code
                /*NavigationLink(destination: loginDestination,
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
                 }*/
                // login button. Pressing this runs the firebase login function
                Button {
                    login()
                }
                label: {Text("Login")
                    .padding()
                    .frame(width: 100.0, height: 50.0)
                    .background(Color.green)
                    .cornerRadius(15)
                    }
                //}
                
            }
            // this bit of code is what keeps the user's login persistent so they stay logged in when they relaunch the app
            .onAppear {
                Auth.auth().addStateDidChangeListener {
                    auth, user in
                    if user != nil {
                        userLogged.toggle()
                    }
                }
            }
        }
    }
    
    /* this code integrates firebase into the application. WIP*/
    func login() {
        Auth.auth().signIn(withEmail: username, password: password) {
        result, error in
        if error != nil { // bad login error
        print(error!.localizedDescription)
            }
        }
        
         // Quick way for me to log in just so i don't have to enter info.
         // Just comment out the previous code of this function and uncomment this
         // userLogged.toggle()
    }
            
    /*var loginDestination: some View {
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
                
    }*/
            
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

