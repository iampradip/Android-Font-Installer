# Android-Font-Installer
Windows batch file to replace fonts easily on rooted Android device

## Important ##
Keep backup of `/system/fonts` from Android device. **Device can fail to boot permanently for some fonts.** Make sure you can restore fonts or ROM from recovery. Target device must be rooted.

## Command Line ##
### install_font.bat ###
`install_font.bat <type> <style> <fontpath>` to install one font at a time.

- `type` can be `sans`, `serif` or `mono`.
- `style` can be `regular`, `italic`, `bold` or `bolditalic`. Only `regular` is allowed for `mono` type.
- `fontpath` is path of font to install.

### install_font\_sans.bat ###
`install_font_sans.bat <regular> <bold> <italic> <bolditalic>` to install 4 font styles for Sans.

All 4 arguments are path to fonts. `install_font.bat` file required.