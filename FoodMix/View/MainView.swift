//
//  MainView.swift
//  FoodMix
//
//  Created by Yuan on 24/02/2022.
//

import SwiftUI
import Introspect

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 0) {
                
                TabView(selection: $viewModel.currentTab) {
                    
                    HomeView()
                        .tag(MainTab.Home)
                    
                    ActivityView()
                        .tag(MainTab.Activity)
                    
                    NotificationView()
                        .tag(MainTab.Notification)
                    
                    SettingView()
                        .tag(MainTab.Profile)
                    
                    
                }
                .overlay(
                    
                    HStack {
                        
                        ForEach(MainTab.allCases, id: \.self) { value in
                            
                            
                            Button {
                                
                                viewModel.currentTab = value
                                
                            } label: {
                                
                                Image(value.rawValue)
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor( viewModel.currentTab == value ? Color("Ultramarine Blue") : .gray)
                                    .frame(width: 24)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .overlay(
                            
                                Group {
                                    
                                    if viewModel.currentTab == value {
                                        
                                        Circle()
                                            .fill(Color("Ultramarine Blue"))
                                            .frame(width: 6, height: 6)
                                            .offset(x: 0, y: 15)
                                            .matchedGeometryEffect(id: "MAINTAB", in: animation)
                                        
                                    }
                                    
                                }
                                
                                ,alignment: .bottom
                            )
                            
                        }
                        
                    }
                    .padding(.top)
                    .padding(.bottom, safeInsets()?.bottom ?? 10)
                    .background(Color.white)
                    .clipShape(MainTabShape())
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0.0, y: 0.0)
                    
                    ,alignment: .bottom
                    
                )
                
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
        }
        .introspectNavigationController { navi in
            navi.navigationBar.isHidden = true
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct MainTabShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius = rect.maxY / 2


        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.minY))
        
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.minY + radius), control: CGPoint(x: rect.minX, y: rect.minY))
            
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
        
        path.addQuadCurve(to: CGPoint(x: rect.maxX - radius, y: rect.minY), control: CGPoint(x: rect.maxX, y: rect.minY))
        
        return path
    }
}