import SwiftUI

struct ContentView: View {
    @State private var randomNumber = 0
    @State private var sliderValue: Double = 100
    
    var body: some View {
        ZStack {
            // Background Image
            Image("matrix")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 1400)
                .clipped()


            // Foreground Content
            VStack {
                Spacer()
                Text("Random Number: \(randomNumber)")
                    .font(.title)
                    .foregroundColor(.white)
                
                HStack {
                    Spacer()
                    // Slider
                    Slider(value: $sliderValue, in: 1...1000, step: 1)
                        .accentColor(.green)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.black.opacity(0)))
                        .frame(maxWidth: 350)
                        .padding(.horizontal, 20)

                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 0).fill(Color.black.opacity(0.5)))
                .padding(.horizontal)
                
                Text("Max Range: \(Int(sliderValue))")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Button(action: {
                    randomNumber = Int.random(in: 1...Int(sliderValue))
                }) {
                    Text("Generate Random Number")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.black)
                        .cornerRadius(5)
                }
                Spacer()
            }
            .padding()
            .background(Color.black.opacity(0.5)) //Slider Background Color
            .cornerRadius(0) //Slider Background
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
