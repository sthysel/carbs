#!/usr/bin/env -S uv run

# /// script
# requires-python = ">=3.8"
# dependencies = [
#   "click",
#   "textual",
# ]
# ///

import re
from pathlib import Path
from typing import List, Tuple

import click
from textual.app import App, ComposeResult
from textual.widgets import DataTable, Footer, Header
from textual.binding import Binding

def parse_i3_configs(directory: Path) -> List[Tuple[str, str, str]]:
    """
    Parses i3 config files in a directory to extract keybindings.

    This function searches for i3wm configuration files, identifies categories,
    keybindings, and the comments immediately preceding them.

    Args:
        directory: The path to the directory to search.

    Returns:
        A list of tuples, where each tuple contains (category, binding, comment).
    """
    bindings = []

    category_re = re.compile(r"^\s*#\s*Category:\s*(.+)")
    bindsym_re = re.compile(r"^\s*bindsym\s+(.+)")
    comment_re = re.compile(r"^\s*#\s*(.*)")

    config_files = list(directory.glob("**/config")) + \
                   list(directory.glob("**/*.conf")) + \
                   list(directory.glob("**/*.config"))

    for config_file in sorted(list(set(config_files))):
        try:
            with open(config_file, "r", encoding="utf-8") as f:
                lines = [line.rstrip() for line in f.readlines()]
        except (IOError, UnicodeDecodeError):
            continue

        current_category = "default"
        for i, line in enumerate(lines):
            if category_match := category_re.match(line):
                current_category = category_match.group(1).strip()
            elif bindsym_match := bindsym_re.match(line):
                binding_text = bindsym_match.group(1).strip().split("#", 1)[0].strip()

                comments = []
                j = i - 1
                while j >= 0:
                    prev_line = lines[j].strip()
                    if not prev_line:
                        j -= 1
                        continue

                    if prev_line.startswith("#") and not category_re.match(prev_line):
                        if comment_match := comment_re.match(prev_line):
                            comments.insert(0, comment_match.group(1).strip())
                        j -= 1
                    else:
                        break

                full_comment = "; ".join(comments)
                bindings.append((current_category, binding_text, full_comment))

    return sorted(bindings, key=lambda x: (x[0].lower(), x[1]))


class I3BindingsApp(App):
    """A Textual app to display i3 keybindings."""
    BINDINGS = [
        Binding("q", "quit", "Quit"),
        Binding("j", "cursor_down", "Down"),
        Binding("k", "cursor_up", "Up"),
        Binding("g", "scroll_top", "Go to Top"),
        Binding("G", "scroll_bottom", "Go to Bottom"),
    ]
    TITLE = "i3 Keybindings Viewer"
    SUB_TITLE = "keys by category"
    CSS = "DataTable { height: 100%; }"

    def __init__(self, bindings_data: List[Tuple[str, str, str]]):
        super().__init__()
        self.bindings_data = bindings_data

    def compose(self) -> ComposeResult:
        yield Header()
        yield DataTable(id="bindings_table")
        yield Footer()

    def on_mount(self) -> None:
        table = self.query_one(DataTable)
        table.cursor_type = "row"
        table.add_columns("Category", "Binding", "Comments")

        if not self.bindings_data:
            table.add_row("No bindings found in the specified directory.")
            return

        last_category = None
        for category, binding, comment in self.bindings_data:
            display_category = category if category != last_category else ""
            table.add_row(display_category, binding, comment)
            last_category = category

    def action_cursor_down(self) -> None:
        """Move cursor down in the DataTable."""
        self.query_one(DataTable).action_cursor_down()

    def action_cursor_up(self) -> None:
        """Move cursor up in the DataTable."""
        self.query_one(DataTable).action_cursor_up()

    def action_scroll_home(self) -> None:
        """Go to the first row in the DataTable."""
        self.query_one(DataTable).action_scroll_home()

    def action_scroll_end(self) -> None:
        """Go to the last row in the DataTable."""
        self.query_one(DataTable).action_scroll_end()

    def action_scroll_top(self) -> None:
        """Move cursor to the first row of the DataTable."""
        self.query_one(DataTable).action_scroll_top()

    def action_scroll_bottom(self) -> None:
        """Move cursor to the last row of the DataTable."""
        self.query_one(DataTable).action_scroll_bottom()


@click.command()
@click.argument(
    "directory",
    default=".",
    type=click.Path(exists=True, file_okay=False, dir_okay=True, readable=True, path_type=Path,),
)
def main(directory: Path):
    """
    Parses i3 config files and displays keybindings in an interactive TUI.
    """
    parsed_bindings = parse_i3_configs(directory)
    app = I3BindingsApp(bindings_data=parsed_bindings)
    app.run()

if __name__ == "__main__":
    main()
