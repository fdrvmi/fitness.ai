//
//  Validator.swift
//  FitnessAI
//
//  Created by Misha Fedorov on 14.12.2024.
//

func validate<T>(_ needValidation: T, validator: (T) -> (Bool, String?)) -> (Bool, String?) {
    validator(needValidation)
}

func validate<T>(_ needValidation: T, validator: (T) -> Bool) -> Bool {
    validator(needValidation)
}
