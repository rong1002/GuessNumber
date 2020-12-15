//
//  Guess1A2B.swift
//  GuessNumber
//
//  Created by Lin Bo Rong on 2020/12/12.
//

import SwiftUI

struct Guess1A2B: View {
    @State var showAlert = false
    @State var GuessNumber = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled()
    @State var Number = ["", "", "", ""]
    @State var A = 0
    @State var B = 0
    @State var result = "格式錯誤"
    @State var RecordNumber = ["0", "0", "0", "0"]
    func Record1A2B() -> String{
        return "\(RecordNumber[0])\(RecordNumber[1])\(RecordNumber[2])\(RecordNumber[3])為：\(A)A\(B)B"
    }
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Text("1A2B")
                    .scaledToFit()
                    .font(.system(size: 40))
                HStack {
                    TextField("1A2B", text: $Number[0])
                        .border(Color.gray, width : 1)
                        .keyboardType(.numberPad)
                    TextField("1A2B", text: $Number[1])
                        .border(Color.gray, width : 1)
                        .keyboardType(.numberPad)
                    TextField("1A2B", text: $Number[2])
                        .border(Color.gray, width : 1)
                        .keyboardType(.numberPad)
                    TextField("1A2B", text: $Number[3])
                        .border(Color.gray, width : 1)
                        .keyboardType(.numberPad)
                }
                Enter1A2B(showAlert: $showAlert, GuessNumber: $GuessNumber, Number: $Number, RecordNumber: $RecordNumber, A: $A, B: $B, result: $result)
                Text("\(Record1A2B())")
                Again1A2B(Number: $Number, GuessNumber: $GuessNumber)
            }
        }
    }
}

struct Guess1A2B_Previews: PreviewProvider {
    static var previews: some View {
        Guess1A2B()
    }
}

struct Again1A2B: View {
    @Binding var Number: [String]
    @Binding var GuessNumber: [Int]
    var body: some View {
        Text("答案為：\(GuessNumber[0])\(GuessNumber[1])\(GuessNumber[2])\(GuessNumber[3])")
            .padding(50)
        Button(action:{
            GuessNumber = GuessNumber.shuffled()
            Number = ["", "", "", ""]
        }){
            Text("Play Again")
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 120/255, green: 113/255, blue: 204/255), Color.init(red: 218/255, green: 217/255, blue: 255/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 5))
            
        }
    }
}

struct Enter1A2B: View {
    @Binding var showAlert: Bool
    @Binding var GuessNumber: [Int]
    @Binding var Number: [String]
    @Binding var RecordNumber: [String]
    @Binding var A: Int
    @Binding var B: Int
    @Binding var result: String
    
    func Record1A2B() -> String{
        return "\(RecordNumber[0])\(RecordNumber[1])\(RecordNumber[2])\(RecordNumber[3])為：\(A)A\(B)B"
    }
    var body: some View {
        Button(action:{
            showAlert = true
            A = 0
            B = 0
            for i in 0...3{
                if Int(Number[i]) == GuessNumber[i]{
                    A = A + 1
                }
                for j in 0...3{
                    if i != j && Int(Number[i]) == GuessNumber[j]{
                        B = B + 1
                    }
                }
            }
            if Number != ["", "", "", ""]{
                result = "\(A)A\(B)B"
            }
            for i in 0...3{
                RecordNumber[i] = Number[i]
                Number[i] = ""
            }
        }){
            Text("確認")
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 255/255, green: 217/255, blue: 218/255), Color.init(red: 204/255, green: 113/255, blue: 120/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 5))
            
        }
        .alert(isPresented: $showAlert) { () -> Alert in
            return Alert(title: Text(result) , dismissButton: .default(Text("OK！")))
        }
    }
}
