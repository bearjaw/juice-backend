# 🚀 juice-backend

A backend written in Swift using [Vapor 4](https://vapor.codes]) to use with Apple Music API. Currently supports search only but working on adding a fully functional backend.

## Requirements

- Vapor 4
- [An Apple Music JWT Token](https://developer.apple.com/documentation/applemusicapi/getting_keys_and_creating_tokens)
- macOS 10.15 or later
- Xcode 11.5 or later
- Swift 5.2

## Getting started

First you need to make sure you install the vapor toolbox. Follow the instructions [here](https://docs.vapor.codes/4.0/install/macos/)

Navigate to the project Root folder and open the `Pacakge.swift` file. This should open Xcode. 
Alternatively use Terminal and enter `open Package.swift`

### Working directory

If you are using Xcode you need to add a custom working directory for the `juice-backend` scheme's run configuration. 

1. Go to the scheme selection ( or use the keyboard command `^ + 0`, `control + 0`)
2. Choose `Edit Scheme`
3. Go to `Run`
4. Choose `Options`
5. Set your custom working directory path

### Environment

Vapor supports `.env`, `.env.development`, and custom environments for storing data. 

⚠️ **Never check sensitive data like passwords or keys into your git repository.** ⚠️ 

Be safe and add all `.env` files to your gitignore to avoid checking in any secrets.

### Run

Choose the `juice-backend` Scheme and build and run the server. That should launch a server at `localhost:8080`.

In your Rest Client you can now perform search requests like the following:

```
localhost:8080/search?term=Tom+Petty&types=artists
```

The response will be an `ResponseRoot` object. See [MusicCore](https://github.com/bearjaw/MusicCore) for more infomation. Also just drop these classes into your iOS or macOS App to share API responses.

## Resources & Documentation

- [Vapor Auth](https://theswiftdev.com/all-about-authentication-in-vapor-4/)
- [Vapor Docs](https://docs.vapor.codes/4.0/install/macos/)
- [MusicKit Docs](https://developer.apple.com/documentation/applemusicapi)
- [JWT MusicKit](https://developer.apple.com/documentation/applemusicapi/getting_keys_and_creating_tokens)
