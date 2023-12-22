import Foundation
import SwiftUI
import MoreSwiftUI

struct SheetAbout: View {
    var body: some View {
        VStack {
            HStack(alignment: .top ,spacing: 10) {
                Image(nsImage: NSImage(named: "AppIcon")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom, spacing: 15) {
                        ZStack {
                            Text("🇺🇦")
                                .rotationEffect(.degrees(-15))
                                .offset(x: 65, y: -16)
                            
                            Text(Bundle.main.appName)
                                .font(.custom("SF Pro Display Bold", size: 36))
                        }
                        
                        Text("Ver: \(Bundle.main.appVersionLong)(\(Bundle.main.appBuild))")
                            .padding(.bottom, 8)
                        
                        Spacer()
                    }
                    
                    Text("Rebuild your life in a playful way")
                        .font(.custom("SF Pro", size: 15))
                        .foregroundColor(Color(hex:0xdfc5a8))
                    
                    Space(15)
                    
                    Text(madeByText)
                        .multilineTextAlignment(.leading)
                        .font(.custom("SF Pro", size: 12))
                        .monospaced()
                }
            }
            .fixedSize()
            .padding(.trailing, 25)
            
            Space(10)
            
            VStack {
                HStack(spacing: 50){
                    Link("Offsite", destination: URL.offsite )
                    
                    Link("Privacy Policy", destination: URL.offsite )
                }
                
                Text("All rights reserved, 2023-"+"\(Date.now.year)" )
            }
        }
        .padding(25)
        .fixedSize()
        .background {
            WindowRealBackgroundView()
        }
        .onTapGesture {
            GlobalDialog.shared.dialog = .none
        }
    }
}

fileprivate extension URL {
    static var offsite: URL { URL(string: "https://filebo.app/")! }
}

extension Bundle {
    public var appName: String           { getInfo("CFBundleName") }
    public var displayName: String       { getInfo("CFBundleDisplayName") }
    public var language: String          { getInfo("CFBundleDevelopmentRegion") }
    public var identifier: String        { getInfo("CFBundleIdentifier") }
    public var copyright: String         { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }
    
    public var appBuild: String          { getInfo("CFBundleVersion") }
    public var appVersionLong: String    { getInfo("CFBundleShortVersionString") }
    //public var appVersionShort: String { getInfo("CFBundleShortVersion") }
    
    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}

fileprivate let madeByText: String =
"""
Development:
     Andrii Kuzmich, Andrii Vynnychenko
Design:
     Andrii Vynnychenko, Andrii Kuzmich
Idea: 
     Andrii Vynnychenko
"""
