import SwiftUI

struct GuessNumber: View {
    @State private var showAlert = false
    @State private var Number = ""
    @State private var GuessNumber : Int = Int.random(in: 0...100)
    @State private var StartNumber : Int = 0
    @State private var EndNumber : Int = 100
    @State private var times: Int = 6
    
    func getNumberText() -> String {
        return "\(StartNumber)~\(EndNumber)"
    }
    var body: some View {
        ZStack(alignment: .top){
            VStack {
                Text("終極密碼")
                    .scaledToFit()
                    .font(.system(size: 35))
                Text("\(getNumberText())")
                    .scaledToFit()
                    .font(.system(size: 70))
                Text("還有\(times)次機會可以回答！")
                    .scaledToFit()
                    .font(.system(size: 20))
                TextField("終極密碼", text: $Number)
                    .scaledToFit()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                EnterNumber(showAlert: $showAlert, Number: $Number, GuessNumber: $GuessNumber, StartNumber: $StartNumber, EndNumber: $EndNumber, times: $times)
                PlayAgain(GuessNumber: $GuessNumber, StartNumber: $StartNumber, EndNumber: $EndNumber, Number: $Number, times: $times)
            }
        }
    }
}
struct GuessNumber_Previews: PreviewProvider {
    static var previews: some View {
        GuessNumber()
    }
}

struct PlayAgain: View {
    @Binding var GuessNumber : Int
    @Binding var StartNumber : Int
    @Binding var EndNumber : Int
    @Binding var Number: String
    @Binding var times: Int
    var body: some View {
        Button(action:{
            let randnum = 0...100
            GuessNumber = randnum.randomElement()!
            StartNumber = 0
            EndNumber = 100
            times = 6
            Number = ""
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

struct EnterNumber: View {
    @Binding var showAlert: Bool
    @Binding var Number: String
    @Binding var GuessNumber: Int
    @Binding var StartNumber: Int
    @Binding var EndNumber: Int
    @Binding var times: Int
    var body: some View {
        Button(action:{
            if GuessNumber != Int(Number){
                times = times - 1
                if GuessNumber > Int(Number)! {
                    StartNumber = Int(Number)! + 1
                    Number = ""
                }
                else if GuessNumber < Int(Number)! {
                    EndNumber = Int("\(Number)")! - 1
                    Number = ""
                }
            }
            showAlert = true
            
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
            if GuessNumber == Int(Number) {
                return Alert(title: Text("恭喜你，猜中了！！！"))
            }else{
                if times != 0{
                    return Alert(title: Text("答錯囉～～～"))
                }
                else {
                    return Alert(title: Text("太遜了！竟然沒有答對"))
                }
            }
        }
    }
}

