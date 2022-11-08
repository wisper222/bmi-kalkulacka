//
//  ContentView.swift
//  BMI Kalkulacka
//
//  Created by Alex Garay on 25/09/2021.
//
import DeviceKit
import SwiftUI
import UIKit




struct ContentView: View {
    
    @State private var showingMoreInfo = true
    @State public var vysledneBmi:Double = 0
    @State var vyska:Double = 0
    @State var vaha:Double = 0
    @State var padding:CGFloat = 0
    @State var vyskaString:String = ""
    @State var vahaString:String = ""
    @State var hodnotaPosuvnika:Double = 25
    @State public var prognoza:String = ""
    @State public var animacia:CGFloat = 0
    @State public var opacitaTextu:CGFloat = 0
    @State public var sirkaSlidera = UIScreen.main.bounds.width * 0.4
    @FocusState var inputActive: Bool
    
    
 
    var body: some View {
        let formattedVysledneBmi = String(format: "%.02f", vysledneBmi)
        
                
        
        VStack {
            
                
                Text("""
                     BMI
                     Kalkulačka
                     """)
                    .fontWeight(.semibold)
                    .padding(.vertical, 60.0)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    
                            
                Image(systemName: "figure.stand")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.bottom, 60.0)
                    
                
                
                    
                
                
        
            
            VStack {
            
                
            
                TextField("Zadaj svoju výšku v cm", text: $vyskaString)
                        .padding(/*@START_MENU_TOKEN@*/.all, 3.0/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width * 0.54, height: UIScreen.main.bounds.height * 0.06, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("AccentColor"), lineWidth: 2)
                        )
                        .padding(.bottom, 15)
                        .keyboardType(.numberPad)
                        .focused($inputActive)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard){
                                Button("Hotovo"){
                                    inputActive = false
                                }
                            }
                        }
                        
                
                
                
                TextField("Zadaj svoju váhu v kg", text: $vahaString)
                        .padding(/*@START_MENU_TOKEN@*/.all, 3.0/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width * 0.54, height: UIScreen.main.bounds.height * 0.06, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("AccentColor"), lineWidth: 2)
                        )
                        .padding(.bottom, 15)
                        .keyboardType(.numberPad)
                        .focused($inputActive)
                        
                        
                        
            
                    
                Spacer()
                
                Text("Tvoje BMI je \(formattedVysledneBmi)")
                    .font(.body)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                    .opacity(opacitaTextu)
                
                
                
                
                ZStack {
                    Capsule()
                        .frame(width: sirkaSlidera, height: 5)
                        .overlay((LinearGradient(gradient: Gradient(colors: [.red, .green, .red]), startPoint: .leading, endPoint: .trailing)))
                    .cornerRadius(17)
                    
                    
                    RoundedRectangle(cornerRadius: 17)
                        .frame(width: 3, height: 12)
                        .position(x: animacia, y: 6)
                        .fixedSize()
                        .padding(.trailing, 130)
                    .animation(.easeInOut(duration: 1.2), value: animacia)
                        
                }
                
                    
                Text(" \(prognoza) ")
                    .font(.footnote)
                    .padding(.top, 7)
                    .opacity(opacitaTextu)
                    
                    
                    
                    
                
                Spacer()
                
                Button(action: vypocitajBmi) {
                    Text("Vypočítať BMI")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 0.84)
                        .cornerRadius(40)
                        .background(Color("CalculateButton"))
                        .cornerRadius(17)
                        
                }
                    
                
                
                
                
                    
                                    
                    
                
            }
            
        }
        .ignoresSafeArea(.keyboard)
        
        
    }
    

    
    func animaciaPosuvnikText(){
        let roundedVysledneBmi:Double = round(vysledneBmi)
        let hodnotaSlideraOptimised:Double  = roundedVysledneBmi*3.2
        
        animacia = CGFloat(hodnotaSlideraOptimised)
        
        if animacia > 134 {
            animacia = 134
        }
            
        if opacitaTextu == 0{
                
                withAnimation(.easeIn(duration: 0.9)){
                    opacitaTextu += 1
                }
                
                
        } else if opacitaTextu == 1{
                
                    opacitaTextu = 0
                
                withAnimation(.easeIn(duration: 0.9)){
                    opacitaTextu += 1
                    
                }
                
        
        }
        
            
        
            
            
        }
    
    
    func vypocitajBmi(){
        vaha = Double(vahaString) ?? 0
        vyska = Double(vyskaString) ?? 0
                
        vysledneBmi = vaha/((vyska*vyska)/10000)
        
        if vysledneBmi.isNaN {
            vysledneBmi = 0
        }
        
        animaciaPosuvnikText()
        
        
        if vysledneBmi < 17.5 && vysledneBmi > 0{
            prognoza = "Trpíš podvýživou"
        } else if vysledneBmi >= 17.5 && vysledneBmi < 25{
            prognoza = "Máš ideálne BMI"
        } else if vysledneBmi >= 25 && vysledneBmi < 30{
            prognoza = "Máš miernu nadváhu"
        } else if vysledneBmi >= 30 && vysledneBmi < 40{
            prognoza = "Trpíš obezitou"
        } else if vysledneBmi > 40{
            prognoza = "Trpíš ťažkou obezitou"
        } else {
            prognoza = ""
        }
        
        
        
        
        
    }
    
    
    
    
}
    





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
