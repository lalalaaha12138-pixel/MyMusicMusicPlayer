# Resources

- `icons/`: images registered in `res.qrc` for the application.
- `source/`: original images and intermediate variants, not bundled in the application.
- `reference/`: reference screenshots, not bundled in the application.
- `res.qrc`: image resources. Aliases preserve existing `qrc:/img/<filename>` URLs.
- `qml.qrc`: QML resources. Aliases preserve existing QML URLs and relative imports.

For a new application icon, place the PNG in `icons/` and add an entry to `res.qrc`:

```xml
<file alias="example.png">icons/example.png</file>
```

Image-processing scripts are in `../scripts/`. The avatar script requires an
explicit `-SourcePath`; both scripts accept custom output locations.
