//
//  InputView.swift
//  StrayBase
//
//  Created by Nino Nozadze on 22.03.25.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let viewModel: InputViewModel
    
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.title)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if viewModel.isSecuredField {
                HStack {
                    if isPasswordVisible {
                        TextField(viewModel.placeholder, text: $text)
                            .font(.system(size: 14))
                    } else {
                        SecureField(viewModel.placeholder, text: $text)
                            .font(.system(size: 14))
                    }
                    
                    if viewModel.showPasswordToggle {
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible
                                  ? SharedUtils.InputView.hideIcon
                                  : SharedUtils.InputView.unhideIcon)
                            .foregroundColor(.gray)
                        }
                        .frame(width: 24, height: 24)
                    }
                    
                }
            } else {
                TextField(viewModel.placeholder, text: $text)
                    .font(.system(size: 14))
            }
            
            Divider()
        }
    }
}

struct InputViewModel {
    let title: String
    let placeholder: String
    var isSecuredField: Bool = false
    var showPasswordToggle: Bool = false
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            InputView(
                text: .constant(""),
                viewModel: .init(
                    title: "Email Address",
                    placeholder: "name@example.com"
                )
            )
            
            InputView(
                text: .constant("password123"),
                viewModel: .init(
                    title: "Password",
                    placeholder: "Enter your password",
                    isSecuredField: true
                )
            )
        }
        .padding()
    }
}
