# AGENTS.md

## Cursor Cloud specific instructions

### Project Overview
YPNavigationBarTransition is an iOS Objective-C framework (CocoaPods library) for smooth `UINavigationBar` transitions. It targets iOS 8.0+ and requires Xcode 9.0+.

### Platform Constraint
This is a **native iOS/Xcode project**. Full compilation (`xcodebuild`), unit tests (Kiwi framework on iOS Simulator), and example app builds **require macOS with Xcode**. On the Linux Cloud Agent VM, the following validations are available:

- **Podspec lint**: `pod lib lint YPNavigationBarTransition.podspec --quick --allow-warnings` — validates the podspec structure, source file references, and metadata.
- **Full podspec lint**: `pod spec lint YPNavigationBarTransition.podspec --allow-warnings` — full validation (skips xcodebuild on Linux).
- **Xcode project analysis**: Use the `xcodeproj` Ruby gem to inspect targets, build settings, schemes, and source file references programmatically.

### Dependency Management
- **Ruby gems**: CocoaPods is installed system-wide via `sudo gem install cocoapods`. The repo's `Gemfile`/`Gemfile.lock` pin very old gem versions (2018-era, bundler 1.16.2) that are **incompatible with Ruby 3.x** on this VM. Do not run `bundle install` with the stock lockfile.
- **CocoaPods**: The root `Podfile` pulls in the Kiwi test framework. Example apps under `Examples/` have their own Podfiles referencing the library via `:path`.

### Key Paths
| Path | Description |
|---|---|
| `YPNavigationBarTransition/` | Library source (`.h`/`.m`, public + internal headers) |
| `YPNavigationBarTransition/internal/` | Private implementation files |
| `YPNavigationBarTransitionTests/` | Unit tests (Kiwi BDD framework) |
| `Examples/Demo-objc/` | Objective-C example app |
| `Examples/Demo-swift/` | Swift example app |
| `YPNavigationBarTransition.podspec` | CocoaPods spec |
| `run_unit_test.sh` | CI test script (macOS only) |

### Build & Test Commands (macOS only)
See `run_unit_test.sh` and `.travis.yml` for the canonical build/test commands. The CI uses `xcodebuild analyze test` against the `YPNavigationBarTransitionLibrary` scheme on an iOS Simulator destination.

### What You Can Do on Linux
1. Validate podspec: `pod lib lint YPNavigationBarTransition.podspec --quick --allow-warnings`
2. Inspect Xcode project structure via the `xcodeproj` gem
3. Review and modify Objective-C/Swift source code
4. Validate header imports and file references
