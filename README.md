# gometalinter

> Gometalinter is a linter for Go source code. https://github.com/alecthomas/gometalinter


# Options


# Examples

```yaml
build:
    steps:
        - gometalinter
```

Using an options:

```yaml
build:
    steps:
        - gometalinter:
        	options: "--deadline=5s --disable=dupl"
        	threshold-warn: 1000
        	threshold-fail: 1000
```

# License

The MIT License (MIT)

# Changelog

## 2.0.0

- Bug fix

## 1.0.0

- Initial release.
