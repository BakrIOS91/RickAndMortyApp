//
//  TaskDelayedModifier.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 04/09/2025.
//

import SwiftUI

struct TaskDelayedModifier: ViewModifier {
    let delay: TimeInterval
    let action: () async -> Void

    func body(content: Content) -> some View {
        content.task {
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            await action()
        }
    }
}

extension View {
    /// Runs `action` as a task after the view appears, delayed by `delay` seconds.
    func taskDelayed(_ delay: TimeInterval, perform action: @escaping () async -> Void) -> some View {
        self.modifier(TaskDelayedModifier(delay: delay, action: action))
    }
}
