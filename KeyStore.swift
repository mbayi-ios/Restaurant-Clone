//
//  KeyStore.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 22/04/2025.
//


protocol KeyStore {
    func set(value: Any, for key: String) -> Void
    func get(_ key: String)-> Any?
    func clearValue(for key: String) -> Void
}
