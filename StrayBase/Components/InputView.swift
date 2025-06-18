//
//  InputView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 22.03.25.
//

import SwiftUI

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    let style: Style
    var isSecure: Bool = false
    var showPasswordToggle: Bool = false
    
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: style == .classic ? 12 : 4) {
            
            Text(title)
                .font(style == .classic ? .footnote : .subheadline)
                .fontWeight(style == .classic ? .semibold : .regular)
                .foregroundColor(style == .classic ? Color(.darkGray) : .secondary)
            
            Group {
                if isSecure {
                    HStack {
                        if isPasswordVisible {
                            TextField(placeholder, text: $text)
                                .font(.system(size: 14))
                        } else {
                            SecureField(placeholder, text: $text)
                                .font(.system(size: 14))
                        }
                        
                        if showPasswordToggle {
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible
                                      ? SharedUtils.InputView.hideIcon
                                      : SharedUtils.InputView.unhideIcon)
                                .foregroundColor(.gray)
                            }
                            .frame(width: 24, height: 24)
                        }
                    }
                } else {
                    TextField(placeholder, text: $text)
                        .font(.system(size: 14))
                }
            }
            .modifier(StyleModifier(style: style))
        }
    }
}

extension InputView {
    
    enum Style {
        case classic
        case rounded
    }
    
}

private struct StyleModifier: ViewModifier {
    let style: InputView.Style
    
    func body(content: Content) -> some View {
        switch style {
        case .classic:
            content
            Divider()
        case .rounded:
            content
                .textFieldStyle(.roundedBorder)
        }
    }
}
