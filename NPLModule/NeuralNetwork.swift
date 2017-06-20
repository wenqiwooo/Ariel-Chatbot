//
//  NeuralNetwork.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/6/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation

let LEARNING_RATE = 0.1
let MOMENTUM = 0.8
let MAX_EPOCHS: Int64 = 150
let DESIRED_ACCURACY: Double = 90

public class NeuralNetwork {
    
    // learning params
    private var learningRate: Double
    private var momentum: Double
    
    // number of neurons
    var nInput: Int
    var nHidden: Int
    var nOutput: Int
    
    // neurons
    var inputNeurons: [Double]
    var hiddenNeurons: [Double]
    var outputNeurons: [Double]
    
    // weights
    var wInputHidden: [[Double]]
    var wHiddenOutput: [[Double]]
    
    // epoch counter
    var epoch: Int64
    var maxEpochs: Int64
    
    // accuracy required
    var desiredAccuracy: Double
    
    // change to weights
    var deltaInputHidden: [[Double]]
    var deltaHiddenOutput: [[Double]]
    
    // error gradients
    var hiddenErrorGradients: [Double]
    var outputErrorGradients: [Double]
    
    // accuracy stats per epoch
    var trainingSetAccuracy: Double
    var validationSetAccuracy: Double
    var generalizationSetAccuracy: Double
    var trainingSetMSE: Double
    var validationSetMSE: Double
    var generalizationSetMSE: Double
    
    // batch learning flag
    var useBatch: Bool
    
    // log file handle
    var logResults: Bool
    var logResolution: Int
    var lastEpochLogged: Int
    
    init(nInput: Int, nHidden: Int, nOutput: Int){
        self.nInput = nInput
        self.nHidden = nHidden
        self.nOutput = nOutput
        
        self.epoch = 0
        
        self.logResults = false
        self.logResolution = 10
        self.lastEpochLogged = -10
        
        self.trainingSetAccuracy = 0
        self.validationSetAccuracy = 0
        self.generalizationSetAccuracy = 0
        self.trainingSetMSE = 0
        self.validationSetMSE = 0
        self.generalizationSetMSE = 0
        
        // create neuron lists
        self.inputNeurons = [Double](count: nInput + 1, repeatedValue: 0)
        // create bias neuron
        self.inputNeurons[nInput] = -1
        
        self.hiddenNeurons = [Double](count: nHidden + 1, repeatedValue: 0)
        // create bias neuron
        self.hiddenNeurons[nHidden] = -1
        
        self.outputNeurons = [Double](count: nOutput, repeatedValue: 0)
        
        // create weight lists (include bias neuron weights)
        self.wInputHidden = [[Double]](count: nInput + 1, repeatedValue: [Double](count: nHidden, repeatedValue: 0))
        self.wHiddenOutput = [[Double]](count: nHidden + 1, repeatedValue: [Double](count: nOutput, repeatedValue: 0))
        
        // create delta lists
        self.deltaInputHidden = [[Double]](count: nInput + 1, repeatedValue: [Double](count: nHidden, repeatedValue: 0))
        self.deltaHiddenOutput = [[Double]](count: nHidden + 1, repeatedValue: [Double](count: nOutput, repeatedValue: 0))
        
        // create error gradient storage
        self.hiddenErrorGradients = [Double](count: nHidden + 1, repeatedValue: 0)
        self.outputErrorGradients = [Double](count: nOutput + 1, repeatedValue: 0)
        
        // default learning params
        self.learningRate = LEARNING_RATE
        self.momentum = MOMENTUM
        
        // use stochastic learning by default
        self.useBatch = false
        
        // stop conditions
        self.maxEpochs = MAX_EPOCHS
        self.desiredAccuracy = DESIRED_ACCURACY
        
        // initialize weights
        self.initializeWeights()
    }
    
    
    // Set learning parameters
    func setLearningParameters(lr: Double, m: Double){
        self.learningRate = lr
        self.momentum = m
    }
    
    // Set max epoch
    func setMaxEpochs(max: Int64){
        self.maxEpochs = max
    }
    
    // Set desired accuracy
    func setDesiredAccuracy(d: Double){
        self.desiredAccuracy = d
    }
    
    // Enable batch learning
    func useBatchLearning(){
        self.useBatch = true
    }
    
    // Enable stochastic learning
    func useStochasticLearning(){
        self.useBatch = false
    }
    
    // Reset neural network
    func resetWeights(){
        self.initializeWeights()
    }
    
    // Feed data through network
    func feedInput(inputs: [Double]) -> [Double]{
        // feed data into network
        self.feedForward(inputs)
        // return results
        return self.outputNeurons
    }
    
    // Train the network
    func trainNetwork(trainingSet: [DataEntry], generalizationSet: [DataEntry], validationSet: [DataEntry]){
        print("Training starting")
        
        // reset epoch and log counters
        self.epoch = 0
        self.lastEpochLogged = -self.logResolution
        
        // Train network using training dataset for training and generalization dataset for testing
        while( (self.trainingSetAccuracy < self.desiredAccuracy || self.generalizationSetAccuracy < self.desiredAccuracy) && epoch < maxEpochs ){
            // store previous accuracy
            var previousTAccuracy = self.trainingSetAccuracy
            var previousGAccuracy = self.generalizationSetAccuracy
            
            // use training set to train network
            self.runTrainingEpoch(trainingSet)
            
            // get generalization set accuracy and MSE
            self.generalizationSetAccuracy = self.getSetAccuracy(generalizationSet)
            self.generalizationSetMSE = self.getSetMSE(generalizationSet)
            
            epoch++
        }
        
        // get validation set accuracy and MSE
        self.validationSetAccuracy = self.getSetAccuracy(validationSet)
        self.validationSetMSE = self.getSetMSE(validationSet)
        
        print("Training complete")
    }
    
    // PRIVATE
    func initializeWeights(){
        // set weights between input and hidden to a random value between -0.5 and 0.5
        for var i = 0; i <= nInput; i++ {
            for var j = 0; j < nHidden; j++ {
                // set weights to random values
                self.wInputHidden[i][j] = (Double)(arc4random() % 1) - 0.5
                // create blank delta
                self.deltaInputHidden[i][j] = 0
            }
        }
        
        // set weights between hidden and output to a random value between -0.5 and 0.5
        for var i = 0; i <= nHidden; i++ {
            for var j = 0; j < nOutput; j++ {
                // set weights to random values
                self.wHiddenOutput[i][j] = (Double)(arc4random() % 1) - 0.5
                // create blank delta
                self.deltaHiddenOutput[i][j] = 0
            }
        }
    }
    
    func runTrainingEpoch(trainingSet: [DataEntry]){
        // incorrect patterns
        var incorrectPatterns: Double = 0
        var mse: Double = 0
        
        for var tp = 0; tp < trainingSet.count; tp++ {
            // feed inputs through network and backpropagate errors
            self.feedForward(trainingSet[tp].pattern)
            self.backpropagate(trainingSet[tp].target)
            
            // pattern correct flag
            var patternCorrect = true
            
            // check all outputs from neural network against desired values
            for var k = 0; k < self.nOutput; k++ {
                // pattern incorrect if desired and output differ
                if (Double(self.getRoundedOutputValue(outputNeurons[k])) != trainingSet[tp].target[k]){
                    patternCorrect = false
                    
                    // calculate MSE
                    mse += pow((outputNeurons[k] - trainingSet[tp].target[k]), 2)
                }
                
                // if pattern is incorrect add to incorrect count
                if (!patternCorrect){
                    incorrectPatterns++
                }
            }
            
            // if using batch learning, update the weights
            if (useBatch){
                self.updateWeights()
            }
            
            // update training accuracy and MSE
            self.trainingSetAccuracy = 100 - (incorrectPatterns/Double(trainingSet.count) * 100)
            self.trainingSetMSE = mse / Double(nOutput * trainingSet.count)
        }
    }
    
    // feed input forward
    func feedForward(inputs: [Double]){
        // set input neurons to input values
        for var i = 0; i < self.nInput; i++ {
            self.inputNeurons[i] = inputs[i]
        }
        
        // calculate hidden layer values - include bias neuron
        for var j = 0; j < self.nHidden; j++ {
            // clear value
            self.hiddenNeurons[j] = 0
            
            // get weighted sum of inputs and bias neuron
            for var i = 0; i <= self.nInput; i++ {
                self.hiddenNeurons[j] +=  self.inputNeurons[i] * self.wInputHidden[i][j]
            }
            
            // set to result of sigmoid
            self.hiddenNeurons[j] = self.activationFunction(self.hiddenNeurons[j])
        }
        
        // Calculating output layer values - include bias neuron
        for var k = 0; k < self.nOutput; k++ {
            // clear value
            self.outputNeurons[k] = 0
            
            // get weighted sum of inputs and bias neuron
            for var j = 0; j <= nHidden; j++ {
                self.outputNeurons[k] += self.hiddenNeurons[j] * wHiddenOutput[j][k]
            }
            
            // set to result of sigmoid
            self.outputNeurons[k] = self.activationFunction(self.outputNeurons[k])
        }
    }
    
    // modify weights according to output
    func backpropagate(desiredValues: [Double]){
        // modify deltas between hidden and output layers
        for var k = 0; k < self.nOutput; k++ {
            // get error gradient for every output node
            self.outputErrorGradients[k] = self.getOutputErrorGradient(desiredValues[k], outputValue: self.outputNeurons[k])
            
            // for all nodes in hidden layer and bias neuron
            for var j = 0; j <= nHidden; j++ {
                // calculate change in weight
                if (!useBatch){
                    self.deltaHiddenOutput[j][k] = self.learningRate * hiddenNeurons[j] * self.outputErrorGradients[k] + self.momentum * self.deltaHiddenOutput[j][k]
                } else {
                    self.deltaHiddenOutput[j][k] += self.learningRate * hiddenNeurons[j] * outputErrorGradients[k]
                }
            }
        }
        
        // modify deltas between input and hidden layers
        for var j = 0; j < self.nHidden; j++ {
            // get error gradient for every hidden node
            self.hiddenErrorGradients[j] = self.getHiddenErrorGradient(j)
            
            // for all nodes in input layer and bias neuron
            for var i = 0; i <= self.nInput; i++ {
                //calculate change in weight
                if (!useBatch){
                    self.deltaInputHidden[i][j] = self.learningRate * self.inputNeurons[i] * self.hiddenErrorGradients[j] + self.momentum * self.deltaInputHidden[i][j]
                } else {
                    self.deltaInputHidden[i][j] = self.learningRate * self.inputNeurons[i] * self.hiddenErrorGradients[j]
                }
            }
        }
        
        // if using stochastic learning update the weights immediately
        if (!useBatch){
            self.updateWeights()
        }
    }
    
    // update weights
    func updateWeights(){
        // input -> hidden weights
        for var i = 0; i <= self.nInput; i++ {
            for var j = 0; j < nHidden; j++ {
                // update weight
                self.wInputHidden[i][j] += self.deltaInputHidden[i][j]
                
                // clear delta only if using batch (previous delta is needed for momentum)
                if (useBatch){
                    self.deltaInputHidden[i][j] = 0
                }
            }
        }
        
        // hidden -> output weights
        for var j = 0; j <= self.nHidden; j++ {
            for var k = 0; k < self.nOutput; k++ {
                // update weight
                self.wHiddenOutput[j][k] += self.deltaHiddenOutput[j][k]
                
                // clear delta only if using batch (previous delta is needed for momentum)
                if (useBatch){
                    self.deltaHiddenOutput[j][k] = 0
                }
            }
        }
    }
    
    // activation function
    func activationFunction(x: Double) -> Double {
        // sigmoid function
        return 1 / (1 + exp(-x))
    }
    
    // get error gradient for output layer
    func getOutputErrorGradient(desiredValue: Double, outputValue: Double) -> Double {
        // return error gradient
        return outputValue * (1 - outputValue) * (desiredValue - outputValue)
    }
    
    // get error gradient for hidden layer
    func getHiddenErrorGradient(j: Int) -> Double {
        // get sum of hidden->output weights * output error gradients
        var weightedSum: Double = 0
        for var k = 0; k < self.nOutput; k++ {
            weightedSum += self.wHiddenOutput[j][k] * self.outputErrorGradients[k];
        }
        
        // return error gradient
        return hiddenNeurons[j] * (1 - hiddenNeurons[j]) * weightedSum
    }
    
    // round up value to get boolean result
    func getRoundedOutputValue(x: Double) -> Int {
        if (x < 0.1){
            return 0
        } else if (x > 0.9){
            return 1
        } else {
            return -1
        }
    }
    
    // feed forward set of patterns and return error
    func getSetAccuracy(set: [DataEntry]) -> Double {
        var incorrectResults: Double = 0;
        
        // for every training input array
        for var tp = 0; tp < set.count; tp++ {
            // feed inputs through network and backpropagate errors
            self.feedForward(set[tp].pattern)
            
            // correct pattern flag
            var correctResult = true
            
            // check all outputs against desired output values
            for var k = 0; k < self.nOutput; k++ {
                // set flag to false if desired and output differ
                if (Double(getRoundedOutputValue(self.outputNeurons[k])) != set[tp].target[k]){
                    correctResult = false
                }
            }
            
            // include training error for an incorrect result
            if (!correctResult){
                incorrectResults++
            }
        }
        
        // calculate error and return as percentage
        return 100 - (incorrectResults / Double(set.count)) * 100
    }
    
    // feed forward set of patterns and return MSE
    func getSetMSE(set: [DataEntry]) -> Double {
        var mse: Double = 0
        
        // for every training input array
        for var tp = 0; tp < set.count; tp++ {
            // feed inputs through network and backpropagate errors
            self.feedForward(set[tp].pattern)
            
            // check all outputs against desired output values
            for var k = 0; k < self.nOutput; k++ {
                // sum all the MSEs together
                mse += pow(self.outputNeurons[k] - set[tp].target[k], 2)
            }
        }
        
        // calculate error and return as percentage
        return mse / Double(self.nOutput * set.count)
    }
    
    
}

