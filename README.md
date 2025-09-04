# Rick and Morty App

A SwiftUI-based iOS application that displays characters from the Rick and Morty universe using The Composable Architecture (TCA) and modern iOS development practices.

## 📱 Features

- **Character List**: Browse and search through Rick and Morty characters
- **Character Details**: View detailed information about each character
- **Search Functionality**: Real-time search with debouncing
- **Pagination**: Infinite scroll loading for character list
- **Error Handling**: Comprehensive error states and retry mechanisms
- **Responsive Design**: Optimized for both iPhone and iPad

## 🏗️ Architecture

### The Composable Architecture (TCA)

This project uses [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) for state management, providing:

- **Predictable State Management**: All state changes flow through reducers
- **Testability**: Easy to unit test business logic
- **Separation of Concerns**: Clear separation between UI and business logic
- **Side Effects Management**: Proper handling of async operations

### Project Structure

```
RickAndMorty/
├── App/                          # App entry point and configuration
├── Network/                      # API layer and data models
│   ├── Client/                   # API clients
│   ├── Model/                    # Data models
│   └── Requests/                 # API request definitions
├── Scenes/                       # Feature modules
│   ├── 1 - CharacterList/        # Character list feature
│   └── 2 - ChracterDetails/      # Character details feature
├── Utils/                        # Utilities and helpers
│   ├── Constants/                # App constants
│   ├── Helpers/                  # Helper functions
│   └── Reusables/                # Reusable UI components
└── Resources/                    # Assets, fonts, and localization
```

### Key Architectural Decisions

1. **Feature-Based Organization**: Each major feature is self-contained with its own state, actions, and views
2. **Dependency Injection**: Using TCA's dependency system for testability
3. **Error Handling**: Centralized error handling with user-friendly messages
4. **API Layer**: Clean separation between network layer and business logic

## 🚀 Getting Started

### Prerequisites

- **Xcode 15.0+**
- **iOS 17.0+**
- **Swift 5.9+**
- **macOS 14.0+** (for development)

### Dependencies

The project uses Swift Package Manager for dependency management:

- **ComposableArchitecture**: State management and architecture
- **BMSwiftNetworking**: Network layer and API handling (by Bakr Mohamed)
- **BMSwiftUI**: UI utilities and extensions (by Bakr Mohamed)
- **Kingfisher**: Image loading and caching
- **LoaderUI**: Loading states and animations

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/BakrIOS91/RickAndMortyApp.git
   cd RickAndMortyApp
   ```

2. **Open the project**:
   ```bash
   open RickAndMorty.xcodeproj
   ```

3. **Build and run**:
   - Select your target device or simulator
   - Press `Cmd + R` or click the Run button
   - The app will build and launch automatically

### Building for Different Configurations

- **Debug**: Default configuration for development
- **Release**: Optimized build for production

## 🧪 Testing

### Test Structure

The project includes comprehensive test coverage:

```
RickAndMortyTests/
├── CoreTest/                     # Core functionality tests
│   ├── AppEnumsTest.swift       # Enum behavior tests
│   ├── AppFontTests.swift       # Font system tests
│   ├── AppTargetTests.swift     # App target tests
│   └── StringConstantsTest.swift # Localization tests
├── FeaturesTest/                 # Feature-specific tests
│   ├── CharacterListFeatureTest.swift    # Character list tests
│   └── ChracterDetailsFeatureTest.swift  # Character details tests
└── NetworkTest/                  # Network layer tests
    ├── ModelTest/                # Data model tests
    └── RequestTest/              # API request tests
```

### Running Tests

```bash
# Run all tests
xcodebuild test -project RickAndMorty.xcodeproj -scheme RickAndMorty

# Run specific test target
xcodebuild test -project RickAndMorty.xcodeproj -scheme RickAndMorty -only-testing:RickAndMortyTests
```

### Test Coverage

- **Unit Tests**: Business logic and state management
- **Integration Tests**: Feature interactions
- **Network Tests**: API client and data models

## 🎨 Design System

### Colors

- **Primary**: App main color for navigation and accents
- **Background**: Light background for content areas
- **Text**: High contrast text colors for readability

### Typography

- **Font Family**: Cairo (Arabic-friendly font)
- **Weights**: Regular, Medium, SemiBold, Bold, ExtraBold
- **Sizes**: Responsive typography scale

### Components

- **Error Views**: Consistent error state presentation
- **Loading States**: Smooth loading animations
- **Search Interface**: Native iOS search experience

## 🌐 Localization

The app supports localization with proper string management:

- **English**: Default language
- **String Management**: Using `Localizable.xcstrings` for modern localization

### Adding New Strings

1. Add the key to `Localizable.xcstrings`
2. Use `Str.keyName.text` in SwiftUI views
3. Test with different language settings

## 📱 Device Support

### iPhone
- **iOS 17.0+**: Full feature support
- **All Screen Sizes**: Responsive design
- **Orientation**: Portrait and landscape support

### iPad
- **iPadOS 17.0+**: Optimized for tablet experience
- **Layout**: Adaptive layouts for larger screens

## 🔧 Configuration

### API Configuration

The app uses the [Rick and Morty API](https://rickandmortyapi.com/):

- **Base URL**: `https://rickandmortyapi.com/api/`
- **Endpoints**: Characters, character details
- **Rate Limiting**: Built-in API rate limiting
- **Caching**: Image caching with Kingfisher


## 🚨 Error Handling

### Error Types

- **Network Errors**: No internet connection, server errors
- **Data Errors**: Invalid responses, parsing failures
- **User Errors**: Search failures, empty results

### Error Recovery

- **Retry Mechanisms**: Automatic and manual retry options
- **User Feedback**: Clear error messages and actions
- **Graceful Degradation**: App continues to function with reduced features

## 📊 Performance

### Optimizations

- **Image Caching**: Efficient image loading and caching
- **Lazy Loading**: Pagination for large datasets
- **Memory Management**: Proper cleanup and resource management
- **Network Optimization**: Request debouncing and caching

### Monitoring

- **Network Monitoring**: Real-time connection status
- **Error Tracking**: Comprehensive error logging
- **Performance Metrics**: Load times and responsiveness

## 🔒 Security

### Data Protection

- **HTTPS Only**: All network requests use secure connections
- **No Sensitive Data**: No user data storage or transmission

## 🤝 Contributing

### Development Workflow

1. **Feature Branches**: Create feature branches from `develop`
2. **Code Review**: All changes require code review
3. **Testing**: Ensure all tests pass
4. **Documentation**: Update documentation as needed

### Code Style

- **Swift Style Guide**: Follow Apple's Swift style guide
- **TCA Patterns**: Consistent TCA implementation
- **Documentation**: Document public APIs and complex logic

## 📝 Assumptions and Decisions

### Technical Assumptions

1. **API Reliability**: Assumed Rick and Morty API is stable and available
2. **Network Conditions**: Handled various network states (offline, slow, etc.)
3. **Device Capabilities**: Assumed modern iOS devices with sufficient memory
4. **User Behavior**: Users expect smooth scrolling and responsive interactions

### Design Decisions

1. **TCA Architecture**: Chosen for its predictability and testability
2. **SwiftUI**: Modern declarative UI framework
3. **Feature-Based Structure**: Easier maintenance and testing
4. **Error-First Design**: Comprehensive error handling from the start

### Testing Decisions

1. **Unit Test Focus**: Business logic and state management
2. **Mock Data**: Consistent test data for reliable tests
3. **Dependency Injection**: Easy mocking and testing
4. **Test Coverage**: Aim for high coverage of critical paths




## 📄 License

This project is free for study and educational purposes.

## 🙏 Acknowledgments

- **Rick and Morty API**: For providing the character data
- **Point-Free**: For The Composable Architecture
- **Open Source Community**: For the various libraries used

---

**Built with ❤️ using SwiftUI and The Composable Architecture**
