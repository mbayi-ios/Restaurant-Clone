//
//  Task.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 21/04/2025.
//


protocol Task {
    associatedtype RepositoryType: Repository
    
    init(repository: RepositoryType)
}