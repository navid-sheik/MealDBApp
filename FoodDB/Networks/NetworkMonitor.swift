//
//  NetworkMonitor.swift
//  FoodDB
//
//  Created by Navid Sheikh on 29/08/2021.
//

import Foundation
import Network




final class NetworkMonitor {
    static  let  shared  =  NetworkMonitor()
    
    private let queue  =  DispatchQueue.global()
    private let monitor : NWPathMonitor
    public var delegate : NoInternetProtocol!
    
    public private(set) var isConnected  : Bool = false{
        didSet{
            guard let delegate  =  delegate else{
                return
            }
            delegate.changedValue()
        }
    }
    
    
    
    public private(set) var connnectionType : ConnectionType =  .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    
    private init(){
        monitor =  NWPathMonitor()
        
    }
    
    public func startMonitoring (){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler =  {[weak self] path in
            self?.isConnected =  path.status != .unsatisfied
            self?.connnectionType =  .wifi
            
            self?.getConnectionType(path)
            print(self?.isConnected ?? "N/A")
        
        }
    }
    
    
    public func stopMonitoring (){
        monitor.cancel()
    }
    private func getConnectionType(_ path : NWPath){
        if path.usesInterfaceType(.wifi){
            connnectionType =  .wifi
        }else if path.usesInterfaceType(.cellular){
            connnectionType =  .cellular
            
        }else if path.usesInterfaceType(.wiredEthernet){
            connnectionType =  .ethernet
            
        }else {
            connnectionType = .unknown
        }
        
        
        
        
    }
    
}
