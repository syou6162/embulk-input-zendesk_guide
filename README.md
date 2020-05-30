# Zendesk Guide input plugin for Embulk

Embulk input plugin of [Zendesk Guide](https://developer.zendesk.com/rest_api/docs/help_center/introduction) (Help Center).

## Overview

* **Plugin type**: input
* **Resume supported**: yes
* **Cleanup supported**: yes
* **Guess supported**: no

## Configuration

- **url**: URL for Zendesk Guide API (string, required)
- **username**: username to use api (string, required)
- **token**: Token (string, required)

## Example

```yaml
in:
  type: zendesk_guide
  url: https://support.example.com/api/v2
  username: user@example.com
  token: xxx
out:
  type: stdout
```


## Build

```
$ rake
```
