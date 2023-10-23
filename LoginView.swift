//
//  LoginView.swift
//  randa-alhajali-ptyltd
//
//  Created by apple on 10/16/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var email : String = ""
    @State var password : String = ""
    
    //password error fields
    @State var password_nonexistant = false
    @State var password_length = false
    @State var no_cap = false
    @State var no_number = false
    @State var no_spesh = false
    
    //email error fields
    @State var email_nonexistant = false
    @State var email_format_err = false
    @State var hostname_err = false
    @State var domainname_err = false
    @State var dot_err = false
    @State var email_at = false
    
    
    class my_email {
        
        var full_email : String
        var dots = [".com", ".org"]
        
        init(emailad: String){
            self.full_email = emailad
            
        }
        
        func split_email(string: String, character: Character) -> [String]{
            let parts = string.components(separatedBy: String(character))
            if parts.count == 2 {
                return parts
            } else {
                return [string, ""]
            }
            
        }
        
        func check_dots(string: String) -> Int {
            var check : Int = 0
            for i in dots {
                if string.contains(i){
                    check += 1
                }
            }
            return check
            
        }
        
        func return_index(string: String) -> Int{
            
            var ind : Int = 0
            
            for i in dots {
                if let range = string.range(of: i){
                    let index = string.distance(from: string.startIndex, to: range.upperBound)
                    ind = index
                    break
                }
                
                else {
                    ind = 0
                }
                
            }
            
            return ind
            
        }
        
    }
    
    
    class my_password {
        var fullpw : String
        let numbers = ["1","2","3","4","5","6","7","8","9","0"]
        let strings = ["!","@","#","$","%","^","&","*"]
        let caps = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        init(string: String){
            self.fullpw = string
        }
        
        func check_cap(string: String) -> Int{
            var decide : Int = 0
            for n in caps{
                if string.contains(Character(n)){
                    decide += 1
                }
            }
            
            return decide
        }
        
        func check_number(string: String) -> Int{
            
            var decide : Int = 0
            for n in numbers{
                if string.contains(Character(n)){
                    decide += 1
                }
            }
            
            return decide
        }
        
        func check_special_char(string: String) -> Int{
            var decide : Int = 0
            
            for n in strings{
                if string.contains(Character(n)){
                    decide += 1
                }
            }
            
            return decide
        }
    }
    
    
    var body: some View {
        ZStack {
            
            Text("RA").foregroundColor(Color("rblue")).font(.system(size: 30, weight: .semibold)).scaleEffect(x:2.5,y:1.25).position(x:120,y:20).underline(true, color: Color("rpink"))
            
            Text("log in").font(.system(size: 30)).foregroundColor(Color("rblue")).offset(y:-140)
            
            
            
            VStack {
                TextField(" email", text: $email).autocapitalization(.none)
                    .frame(width:240,height:30)
                    .padding(.vertical, 5).padding(.horizontal,10).onChange(of: email) {newValue in email_nonexistant = false; domainname_err = false; hostname_err = false; dot_err = false}
            }.background(Color("back_g")).cornerRadius(15).offset(x:0, y:-70)
            
            VStack {
                TextField(" password", text: $password).autocapitalization(.none)
                    .frame(width:240,height:30)
                    .padding(.vertical, 5).padding(.horizontal,10).onChange(of: password) {newValue in if !password.isEmpty{password_nonexistant = false; password_length = false; no_cap = false; no_number = false; no_spesh = false}}
            }.background(Color("back_g")).cornerRadius(15).offset(x:0, y:-15)
            
            Button("forgot password"){
                
                
            }.foregroundColor(Color("rblue")).offset(x:-60,y:20)
            
            Button("log in "){
                
                //perform email and password checks
                lazy var email_class = my_email(emailad: email)
                lazy var password_class = my_password(string: password)
                
                let host_dom_split = email_class.split_email(string: email, character: "@")
                let hostname = host_dom_split[0]
                let domain = host_dom_split[1]
                let dots_status = email_class.check_dots(string: email)
                
                let check_cap = password_class.check_cap(string: password)
                let check_number = password_class.check_number(string: password)
                let check_spesh = password_class.check_special_char(string: password)
                
                
                if email.count == 0 {
                    email_nonexistant = true
                }
                
                else if hostname.count == 0 {
                    hostname_err = true
                }
                
                else if domain.count == 0 {
                    domainname_err = true
                }
                
                else if dots_status == 0 {
                    dot_err = true
                }
                
                else if password.count == 0 {
                    password_nonexistant = true
                }
                
                else if password.count < 8 {
                    password_length = true
                }
                
                else if check_cap == 0 {
                    no_cap = true
                }
                
                else if check_number == 0 {
                    no_number = true
                }
                
                else if check_spesh == 0 {
                    no_spesh = true
                }
                
                
                
            }.font(.system(size:20)).padding(.vertical, 11).padding(.horizontal, 105).background(Color("rblue")).foregroundColor(Color.white).cornerRadius(15).overlay(
                RoundedRectangle(cornerRadius: 15).stroke(Color("rpink"), lineWidth: 2)).offset(y:85)
            
            
            
            
            ZStack{
                
                if email_nonexistant == true {
                    Text("no email provided").font(.system(size:15)).foregroundColor(Color.red).offset(x:-54,y:125)
                }
                
                else if hostname_err == true {
                    Text("use hostname before @").font(.system(size:15)).foregroundColor(Color.red).offset(x:-38,y:125)
                }
                
                else if email_at == true {
                    Text("use @ symbol").font(.system(size:15)).foregroundColor(Color.red).offset(x:-68,y:125)
                }
                
                else if domainname_err == true {
                    Text("use domain after @").font(.system(size:15)).foregroundColor(Color.red).offset(x:-50,y:125)
                }
                
                else if dot_err == true {
                    Text("correct format - name@domain.com").font(.system(size:15)).foregroundColor(Color.red).offset(x:4,y:125)
                }
                
                else if password_nonexistant == true {
                    Text("no password provided").font(.system(size:15)).foregroundColor(Color.red).offset(x:-45,y:125)
                }
                
                else if password_length == true {
                    Text("password should be 8 char in length").font(.system(size:15)).foregroundColor(Color.red).offset(x:0,y:125)
                }
                
                
                else if no_cap == true {
                    Text("password should have an uppercase letter").font(.system(size:15)).foregroundColor(Color.red).offset(x:20,y:125)
                }
                
                else if no_number == true {
                    Text("password should have a number").font(.system(size:15)).foregroundColor(Color.red).offset(x:0,y:125)
                }
                
                else if no_spesh == true {
                    Text("password should have a special character").font(.system(size:15)).foregroundColor(Color.red).offset(x:20,y:125)
                }
                
                
            }
            
        }
    }
    
}


    struct LoginView_Previews: PreviewProvider {
            static var previews: some View {
                LoginView()
            }
    }
