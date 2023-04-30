# qbx-dispatch

A dispatch system for FiveM using qbx-core.

## Installation
* <> Code -> Download ZIP

Either
* Unzip qbx-dispatch into your resources folder (wherever you want)
* Add 'ensure qbx-dispatch' to the server.cfg
Or
* Unzip qbx-dispatch into your [qbx] folder (will start automatically)
* Modify the config to your liking.
* Restart the server.

## Dependencies

- [qbx-core](https://github.com/qbox-framework/qbx-core) (Latest)
- [ox_lib](https://github.com/overextended/ox_lib)
- [interact-sound](https://github.com/Qbox-project/interact-sound) (Comes with qbx-core and has sounds included)

## Preview
![image](https://user-images.githubusercontent.com/97451137/235332585-22ba4f8f-bf4a-48dd-a4b6-df3dd5324c1b.png)

## Export example

To trigger an alert you would use an export (client/exports.lua) like this:
```lua
    exports['qbx-dispatch']:DriveBy()
```

You can add your own exports or use the CustomCall export to create your own alerts.