# Herdr Pane Autorename

[Herdr](https://herdr.dev) plugin that automatically renames panes with the name of the current running process.

## Requirements

- [Herdr](https://herdr.dev) v0.8.0 or later
- [jq](https://jqlang.org)

## Install

```bash
herdr plugin install b12o/herdr-pane-autorename
```

Installation requires a Herdr server restart:

```bash
herdr server stop
herdr
```

## Actions

```bash
herdr plugin action invoke herdr-pane-autorename.stop # stop the autorename watcher
herdr plugin action invoke herdr-pane-autorename.resume # resume the autorename watcher
```

## Uninstall

```bash
herdr plugin action invoke herdr-pane-autorename.stop
herdr plugin uninstall herdr-pane-autorename
```

## License

[MIT](LICENSE)
