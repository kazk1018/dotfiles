# dotfiles

managed by [chezmoi](https://www.chezmoi.io/)

## File structure

```bash
.
├── .chezmoi.toml.tmpl # basic configurations
├── dot_config # ~/.config
│   ├── ghostty
│   ├── git
│   ├── helix
│   ├── mise
│   ├── sheldon
│   ├── starship.toml
│   └── zsh
└── README.md
```

## Usage

### Prerequisites

- Download fonts from [UDEV Gothic 35NFLG](https://github.com/yuru7/udev-gothic)

### Installation

```bash
# install chezmoi in `$PWD/bin`
# ref: https://www.chezmoi.io/install/#one-line-binary-install
sh -c "$(curl -fsLS get.chezmoi.io)"

# initialize
chezmoi init https://github.com/kazk1018/dotfiles.git

# apply
chezmoi apply
```
