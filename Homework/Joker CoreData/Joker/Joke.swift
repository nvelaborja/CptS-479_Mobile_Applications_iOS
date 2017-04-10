//
//  Joke.swift
//  Joker
//
//  Created by Nathan VelaBorja on 1/23/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import Foundation

class Joke {
    var firstLine: String
    var secondLine: String
    var thirdLine: String
    var answerLine: String
    
    init(_ first: String = "", _ second: String = "", _ third: String = "", _ answer: String = "") {
        firstLine = first;
        secondLine = second;
        thirdLine = third;
        answerLine = answer;
    }
    
}

class JokeArray {
    var jokes: [Joke]
    
    init(_ Jokes: [Joke] = []) {
        jokes = Jokes
    }
    
    func add(_ joke: Joke) {
        jokes.append(joke)
    }
}

