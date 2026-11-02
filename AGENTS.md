# Fairshare iOS: agent instructions

- SwiftUI app, iOS 26, Xcode 26. Open `Fairshare.xcodeproj`; the project is generated from `project.yml` (XcodeGen), so edit `project.yml` when adding targets.
- Build and test on the iPhone 17 Pro simulator:
  `xcodebuild test -project Fairshare.xcodeproj -scheme Fairshare -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.5'`
- Every crash fix ships with a unit test in `FairshareTests/` and, when the crash is reachable from the UI, a UI test in `FairshareUITests/`.
- Reproduce crashes in the Simulator before fixing them, and attach a screenshot or recording of the fixed flow to the pull request.
- Money is integer cents.
