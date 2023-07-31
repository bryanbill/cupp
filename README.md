# Cupp Lang

A simple, easy to use, and powerful programming language.

## Installation

### Linux and macOS

```bash
curl -s https://raw.githubusercontent.com/bryanbill/cupp/main/install.sh | bash
```

### Windows

```powershell
iwr https://raw.githubusercontent.com/bryanbill/cupp/main/install.ps1 -useb | iex
```

## Usage

```bash
cupp [options] [file]
```

## Options

| Option | Description |
| --- | --- |
| `-h`, `--help` | Print help message |
| `-v`, `--version` | Print version number |
| `-c`, `--compile` | Compile to Bytecode |
| `-r`, `--run` | Run Bytecode |

## Examples

```bash
cupp -c hello.cupp
```

```bash
cupp -r hello.cupp
```

## License

Apache License 2.0
