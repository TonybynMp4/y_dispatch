# qbx_dispatch

A dispatch system for FiveM using qbx_core.

## Installation
* <> Code -> Download ZIP

Either
* Unzip qbx_dispatch into your resources folder (wherever you want)
* Add 'ensure qbx_dispatch' to the server.cfg

Or

* Unzip qbx_dispatch into your [qbx] folder (will start automatically)

Then

* Modify the config to your liking.
* Restart the server.

## Dependencies

- [qbx_core](https://github.com/qbox-project/qbx_core/releases/latest)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_inventory](https://github.com/overextended/ox_inventory) (Used in gun related alerts to get the name of the weapon)

- [interact-sound](https://github.com/Qbox-project/interact-sound) (Supported, not the only way to use sounds tho)
- 
## Preview
![image](https://user-images.githubusercontent.com/97451137/235332585-22ba4f8f-bf4a-48dd-a4b6-df3dd5324c1b.png)

## Export example

To trigger an alert you would use an export (client/exports.lua) like this:
```lua
    exports.qbx_dispatch:DriveBy()
```

You can add your own exports or use the CustomCall export to trigger customized alerts.
