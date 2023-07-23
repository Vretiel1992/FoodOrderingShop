// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct Colors {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3364e0"></span>
  /// Alpha: 100% <br/> (0x3364e0ff)
  internal static let activeDishTag = Colors(rgbaValue: 0x3364e0ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3364e0"></span>
  /// Alpha: 100% <br/> (0x3364e0ff)
  internal static let activeTabBarItem = Colors(rgbaValue: 0x3364e0ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e8e9ec"></span>
  /// Alpha: 100% <br/> (0xe8e9ecff)
  internal static let borderTabBar = Colors(rgbaValue: 0xe8e9ecff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f8f7f5"></span>
  /// Alpha: 100% <br/> (0xf8f7f5ff)
  internal static let inactiveDishTag = Colors(rgbaValue: 0xf8f7f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a5a9b2"></span>
  /// Alpha: 100% <br/> (0xa5a9b2ff)
  internal static let inactiveTabBarItem = Colors(rgbaValue: 0xa5a9b2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f8f7f5"></span>
  /// Alpha: 100% <br/> (0xf8f7f5ff)
  internal static let primaryBackgroundColor = Colors(rgbaValue: 0xf8f7f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3364e0"></span>
  /// Alpha: 100% <br/> (0x3364e0ff)
  internal static let secondaryBackgroundColor = Colors(rgbaValue: 0x3364e0ff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let components = RGBAComponents(rgbaValue: rgbaValue).normalized
    self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
}

private struct RGBAComponents {
  let rgbaValue: UInt32

  private var shifts: [UInt32] {
    [
      rgbaValue >> 24, // red
      rgbaValue >> 16, // green
      rgbaValue >> 8,  // blue
      rgbaValue        // alpha
    ]
  }

  private var components: [CGFloat] {
    shifts.map { CGFloat($0 & 0xff) }
  }

  var normalized: [CGFloat] {
    components.map { $0 / 255.0 }
  }
}

internal extension Color {
  convenience init(named color: Colors) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
