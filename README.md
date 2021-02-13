# flutter_taking_photo

to use camera plugin you have to change minimum android sdk version to 21
android/app.build.gradle => minSdkVersion 21

dont move to null safety because path provider and camera dependency not ready for null safety

## dependencies
- camera: ^0.7.0+2 have different style to use path location (example use camera: 0.5.8+17)
- path: ^1.8.0
- path_provider: ^1.6.27