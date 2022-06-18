# LSP Range Format

This plugin use build in LSP to format only selected part of the text
## Demo
![](https://github.com/Djancyp/lsp-range-format/blob/main/images/demo.gif)
## Installation

```bash
use {"Djancyp/lsp-range-format"}
```

## Usage

You need to add key mapping to v mode.

```bash
map("v", "fr", ":lua require'lsp-range-format'.format()<CR>")

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
