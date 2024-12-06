# Contributing to Tickit

Thank you for your interest in contributing to our Flutter project! This document provides guidelines and steps for contributing.

## Development Environment Setup

1. Install the following prerequisites:
   - Flutter SDK (latest stable version)
   - Android Studio / VS Code with Flutter plugin
   - Git

2. Clone the repository:
   ```bash
   git clone https://github.com/doyeon0307/Tickit-frontend
   cd Tickit-frontend
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Code Style Guidelines

We follow the official [Flutter style guide](https://flutter.dev/docs/development/tools/formatting) and these additional conventions:

### Naming Conventions
- Use `camelCase` for variable and method names
- Use `PascalCase` for class names and type parameters
- Use `lowercase_with_underscores` for file names

### Code Organization
- Keep files focused and under 300 lines of code
- Group related widgets in separate files
- Use Clean Architecture and MVVM pattern:
   - `data`: Handles external data operations (API calls)
   - `domain`: Contains use cases
   - `ui`: Manages user interface with MVVM pattern (View, ViewModel, State)
  ```
  lib/
  ├── data/
  │   ├── feature1/
  │   │   ├── body/
  │   │   ├── entity/
  │   │   ├── repository.dart
  │   │   └── remote_data_source.dart
  │   └── feature2/
  ├── domain/
  │   ├── feature1/
  │   │   ├── model/
  │   │   └── use_case.dart
  │   └── feature2/
  ├── ui/
  │   ├── feature1/
  │   │   ├── component/
  │   │   ├── state.dart
  │   │   ├── view.dart
  │   │   └── view_model.dart
  │   └── feature2/
  └── main.dart
  ```

## How to Contribute

### Creating Issues
- Check existing issues before creating a new one
- Use issue templates if available
- Clearly describe the problem or enhancement
- Include steps to reproduce for bugs
- Add relevant labels

### Pull Request Process
1. Create a new branch from `dev`:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and commit:
   ```bash
   git commit -m "feat: add new feature"
   ```
   Follow [Conventional Commits](https://www.conventionalcommits.org/) format

3. Push your branch and create a Pull Request
4. Wait for code review and address any feedback
5. Once approved, your PR will be merged

### Commit Message Guidelines
Format: `type(scope): message`

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

## Testing
- Write tests for new features
- Ensure all tests pass before submitting PR:
  ```bash
  flutter test
  ```
- Aim for good test coverage

## Documentation
- Update README.md if adding new features
- Include inline documentation for complex logic
- Update API documentation if applicable

## Questions?
Feel free to open an issue or contact the maintainers at dodo03@khu.ac.kr.

Thank you for contributing!
