//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Axel Collard Bovy on 1/8/22.
//

import SwiftUI

let possibleChoices = ["Rock", "Paper", "Scissors"]
let winningMoves = ["Paper", "Scissors", "Rock"]
let losingMoves = ["Scissors", "Rock", "Paper"]
let emojisForChoices = [
    "Rock": "🪨",
    "Paper":"📄",
    "Scissors":"✂️"
]

struct ContentView: View {
    @State var appsMove = Int.random(in: 0..<3)
    @State var shouldWin = Bool.random()
    @State var playerScore = 0
    @State var currentQuestion = 0
    @State var isShowingGameOverAlert = false

    var body: some View {
        VStack {
            Text("Rock, Paper, Scissors")
                .font(.largeTitle)
                .padding()
            Spacer()
            VStack {
                Text("App's move \(possibleChoices[appsMove])")
                Text("Should \(shouldWin ? "win" : "lose")")
            }
            .font(.subheadline)
            Spacer()
            VStack {
                Text("Choose one of the following:")
                    .font(.headline)
                HStack {
                    ForEach(possibleChoices, id: \.self) { choice in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(.thinMaterial)
                            RoundedRectangle(cornerRadius: 15.0)
                                .stroke()
                            Text(emojisForChoices[choice] ?? choice)
                                .font(.system(size: 60))
                        }.onTapGesture {
                            onChoiceTap(choice)
                        }
                        .padding()
                        .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            Spacer()
            Text("Your score is: \(playerScore)")
                .font(.headline)
            Spacer()
        }
        .alert("Game over", isPresented: $isShowingGameOverAlert, actions: {
            Button("Play again", action: restartGame)
            Button("Exit game") {
                exit(0)
            }
        }, message: {
            Text("Your final score after 10 rounds was: \(playerScore)")
        })
        .onAppear(perform: nextQuestion)

    }

    func onChoiceTap(_ choice: String) {
        guard choice != possibleChoices[appsMove] else {
            nextQuestion()
            return
        }

        if (shouldWin && choice == winningMoves[appsMove])
            || (!shouldWin && choice == losingMoves[appsMove]) {
            playerScore += 10
        } else {
            playerScore -= 10
        }
        nextQuestion()
    }

    func nextQuestion() {
        shouldWin.toggle()
        appsMove = Int.random(in: 0..<3)
        currentQuestion += 1

        if currentQuestion == 10 {
            isShowingGameOverAlert = true
        }
    }

    func restartGame() {
        playerScore = 0
        currentQuestion = 0
        nextQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
