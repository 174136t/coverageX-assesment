# coverageX-assesment
coverageX- Technical Assesment

A native iOS application built with programmatic UI that displays users from the Random User API with a clean, modern interface.

## Features
- Fully programmatic UI (no storyboards)
- Native UITableView with custom cells
- Detailed user view
- Pull-to-refresh functionality
- Image caching for better performance
- Proper loading states and error handling
- MVVM architecture pattern
- Auto Layout with programmatic constraints

## Requirements
- iOS 14.0+
- Xcode 14.0+
- Swift 5.0+

## Setup Instructions
1. Clone the repository
2. Open `UserListApp-CoverageX.xcodeproj` in Xcode
3. Select your target device/simulator
4. Build and run (⌘+R)

## Architecture
- **MVVM Pattern**: Clear separation between View, ViewModel, and Model
- **Programmatic UI**: All UI built using code with Auto Layout
- **Delegate Pattern**: Communication between ViewModels and ViewControllers
- **Service Layer**: Dedicated network service for API calls
- **Custom UITableViewCell**: Reusable cell design with programmatic layout
- **Extensions**: UIColor and UIImageView extensions for convenience

## Key Technical Decisions
- **No Storyboards**: Demonstrates advanced iOS development skills
- **Programmatic Constraints**: Uses custom anchor extension for clean layout code
- **Image Caching**: NSCache implementation for better performance
- **Modular Architecture**: Clean separation of concerns
- **Constants**: Centralized UI constants for consistency


