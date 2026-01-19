import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @State private var randomNumber = 0
    @State private var maxRange: Double = 100
    @State private var textFieldValue: String = "100"
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            // Background Image
            Image("RNG_Background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 15) {
                    // Logo at top
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                    
                    // Random Number Display
                    VStack(spacing: 5) {
                        Text("Your Random Number:")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        
                        Text("\(randomNumber)")
                            .font(.system(size: 72, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 15)
                    
                    // Max Range Controls
                    VStack(spacing: 15) {
                        // Main increment/decrement buttons with text field
                        HStack(spacing: 15) {
                            // Decrement button
                            Button(action: {
                                adjustMaxRange(by: -1)
                            }) {
                                Image(systemName: "minus")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Color(red: 0, green: 0.8, blue: 0))
                                    .cornerRadius(10)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // Text field for direct input
                            TextField("", text: $textFieldValue)
                                .font(.system(size: 36, weight: .semibold))
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocused)
                                .frame(width: 140, height: 70)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                            
                            // Increment button
                            Button(action: {
                                adjustMaxRange(by: 1)
                            }) {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Color(red: 0, green: 0.8, blue: 0))
                                    .cornerRadius(10)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        // Max Range label
                        Text("Max Range: \(Int(maxRange))")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        // Quick jump buttons
                        HStack(spacing: 12) {
                            QuickJumpButton(value: -10) {
                                adjustMaxRange(by: -10)
                            }
                            QuickJumpButton(value: -5) {
                                adjustMaxRange(by: -5)
                            }
                            QuickJumpButton(value: 5) {
                                adjustMaxRange(by: 5)
                            }
                            QuickJumpButton(value: 10) {
                                adjustMaxRange(by: 10)
                            }
                        }
                        
                        // Slider
                        Slider(value: $maxRange, in: 0...1000, step: 1)
                            .accentColor(Color(red: 0, green: 0.8, blue: 0))
                            .frame(width: 300)
                            .padding(.vertical, 20)
                    }
                    
                    // Generate Button
                    Button(action: {
                        generateNumber()
                    }) {
                        Text("Generate Random Number")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 20)
                            .background(Color(red: 0, green: 0.8, blue: 0))
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                
                // Banner Ad
                GeometryReader { geo in
                    BannerAdView(width: geo.size.width)
                        .frame(width: geo.size.width, height: 50)
                }
                .frame(height: 50)
                .background(Color.black)
            
            }
        }
        .preferredColorScheme(.dark)
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    if isTextFieldFocused {
                        isTextFieldFocused = false
                    }
                }
        )
        .onChange(of: textFieldValue) { oldValue, newValue in
            let filtered = newValue.filter { $0.isNumber }
            if filtered != newValue {
                textFieldValue = filtered
            }
        }
        .onChange(of: isTextFieldFocused) { oldValue, newValue in
            if !newValue {
                updateMaxRangeFromTextField()
            }
        }
        .onChange(of: maxRange) { oldValue, newValue in
            textFieldValue = "\(Int(newValue))"
        }
    }
    
    private func generateNumber() {
        if maxRange > 0 {
            randomNumber = Int.random(in: 0...Int(maxRange))
        } else {
            randomNumber = 0
        }
        isTextFieldFocused = false
    }
    
    private func adjustMaxRange(by amount: Int) {
        let newValue = Int(maxRange) + amount
        maxRange = Double(max(0, min(1000, newValue)))
        textFieldValue = "\(Int(maxRange))"
    }
    
    private func updateMaxRangeFromTextField() {
        if let value = Int(textFieldValue) {
            maxRange = Double(max(0, min(1000, value)))
            textFieldValue = "\(Int(maxRange))"
        } else {
            textFieldValue = "\(Int(maxRange))"
        }
    }
}

struct QuickJumpButton: View {
    let value: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("\(value > 0 ? "+" : "")\(value)")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 70, height: 50)
                .background(Color(red: 0, green: 0.8, blue: 0))
                .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
