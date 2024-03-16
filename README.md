# chroma-enginesoundmenu - FiveM
Easy to use menu to allow you to change your engine sound ingame - syncs to all clients via statebags.

## Dependencies
[ox_lib](https://github.com/overextended/ox_lib)

The default permission ace for this command is `enginesoundmenu` - you can give this to a group such as:
`add_ace group.donator enginesoundmenu allow`

If you want to edit the permissions check such as for jobs or your framework, edit the `server.lua`

You can configure your sounds via `config.lua` as well as the default keybind - leave it blank if no default keybind is wanted.