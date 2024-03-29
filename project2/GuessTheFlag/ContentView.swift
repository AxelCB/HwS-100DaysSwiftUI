//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Axel Collard Bovy on 16/01/2022.
//

import SwiftUI

fileprivate let labels = [
    "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
    "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
    "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
    "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
    "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
    "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
    "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
    "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
    "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
    "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
    "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
]

struct ContentView: View {

    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var rounds = 8
    @State private var showingResults = false
    @State private var flagsRotationAnimationAmount = [0.0, 0.0, 0.0]
    @State private var flagsOpacityAnimationAmount = [1.0, 1.0, 1.0]

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flagName: countries[number])
                                .opacity(flagsOpacityAnimationAmount[number])
                                .scaleEffect(flagsOpacityAnimationAmount[number])
                                .rotation3DEffect(.degrees(flagsRotationAnimationAmount[number]), axis: (x: 0, y: 1, z: 0))
                                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game over", isPresented: $showingResults) {
            Button("Restart", action: restart)
        } message: {
            Text("Your score after 8 rounds was \(score)")
        }
    }

    func flagTapped(_ number: Int) {
        withAnimation(.easeInOut) {
            flagsRotationAnimationAmount[number] += 360
            flagsOpacityAnimationAmount[number] = 1.25
            (0..<3).filter({$0 != number}).forEach { otherFlag in
                flagsOpacityAnimationAmount[otherFlag] = 0.25
            }
        }
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            score -= 1
        }
        rounds -= 1
        showingScore = true
    }

    func askQuestion() {
        for flagIndex in 0..<3 {
            flagsOpacityAnimationAmount[flagIndex] = 1.0
        }
        if rounds > 0 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            showingResults = true
        }

    }

    func restart() {
        score = 0
        rounds = 8
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
