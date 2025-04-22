//
//  AppState.swift
//  lunchbox
//
//  Created by Ambrose Mbayi on 22/04/2025.
//



struct AppState {
    let sessionStore: SessionStore
    let themeConfigurationStore: ThemeConfigurationStore
    let storesConfigurationStore: StoresConfigurationStore
    
    let themeConfigurationState: ThemeConfigurationState
    let storesConfigurationState: StoresConfigurationState
    
    
    let authStatus: AuthStatus
    let sessionCustomer: SessionCustomer
    
    init(sessionStore: SessionStore, themeConfigurationStore: ThemeConfigurationStore, storesConfigurationStore: StoresConfigurationStore) {
        self.sessionStore = sessionStore
        
        self.themeConfigurationStore = themeConfigurationStore
        self.storesConfigurationStore = storesConfigurationStore
        
        self.themeConfigurationState = ThemeConfigurationState(themeConfigurationStore: themeConfigurationStore)
        self.storesConfigurationState = StoresConfigurationState(storesConfigurationStore: storesConfigurationStore)
        
        self.authStatus = AuthStatus(sessionStore: sessionStore)
        self.sessionCustomer = SessionCustomer(sessionStore: sessionStore)
       
    }
}