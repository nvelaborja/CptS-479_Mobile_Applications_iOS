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
    var rating : Int = 0
    
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
}

/*
class Player {
    var direction: Direction
    var speed: Float
    var inventory: [String]?   // initialized to nil
    
    init (speed: Float, direction: Direction) {
        self.speed = speed
        self.direction = direction
    }
    
    func energize() {
        speed += 1.0
    }
}

Add a file called “Joke.swift” that will contain a class called “Joke” with four string
variables: firstLine, secondLine, thirdLine and answerLine. The Joke class should also have an init() function that takes the four strings as parameters, where each one has a default value of the empty string “”.
 
 */
