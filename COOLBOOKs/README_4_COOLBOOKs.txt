Welcome to the COOLBOOK system, a fancy way to make overly complicated TGUI-based books in SS13

## HOW 2 MAKE COOLBOOK
A COOLBOOK is made up of three parts: The Folder, the Index, and the Chapters.
When the game starts up, it will look for all folders in the `COOLBOOKs` directory and load their contents into the COOLBOOK subsystem.

### The Folder
The Folder defines which files are associated with this book. If the file is in the folder, it will be loaded into the book.

### The Index
The Index is a file named `index.json`, which holds all the metadata about the book itself, as well as the text on the index page.
There *must* be an `index.json` in the folder, or the book will error out and not be loaded.
Inside the index file, there are a few fields that define the book: (Note: all are optional except the key)
- `key`: The key of the book, as it will be referenced in the code. This must be unique, though it won't be visible to the player.
- `title`: The title of the book, as it will appear on the index page and the book item. This will appear to the player.
- `author`: The author of the book, as it will appear on the index page. This will appear to the player.
- `description`: The description of the book, as it will appear on the book item. This will appear to the player.
- `content`: The text of the index, as it will appear on the index page. This will appear to the player.
Note: The Index does not define which files are chapters. The subsystem will assume any .txt or .json file in the folder is a chapter.
Also Note: While autopage and is_index are technically valid keys, don't change them from the values in the example book. They're used internally.

### The Chapters
The Chapters are the actual pages of the book. They can be either .txt or .json files, and will be loaded into the book in alphabetical order.
These hold the actual text of the book, and accept HTML for the most part.
Blank lines will add <br><br>, so it'll break up your paragraphs for you. You can add <br> manually, but it'll just add another line break.
As chapters can be made from .txt or .json, there are two ways to format them.
The title of the chapter is also used as the key index for the chapter, so it must be unique.

#### chapter.txt
This is the simplest way to make a chapter. It's just a text file full of text. You can use HTML tags to format it, if you want.
You can set the chapter title by having a line that starts with %TITLE: and then the title of the chapter. Don't put a space between the colon and the title.
You can force a page break by having a line that is just --PAGEBREAK-- on it's own line. This will force the next line to be on a new page.
If no --PAGEBREAK--s appear, the chapter will be split into pages automatically. Typically after 20 lines in the file.
Everything else that isn't a title or a page break will be treated as text. That's it!

#### chapter.json
This is the (slightly) more complicated way to make a chapter. It works roughly the same as .txt, but its metadata and content are defined with keys.
The keys are as follows:
- `title`: The title of the chapter. This will appear to the player.
- `content`: The content of the chapter. This is formatted sorta the same as the .txt file. Refer to the example book!
- `autopage`: Whether or not to automatically split the chapter into pages. Also set to FALSE if any lines contain --PAGEBREAK--

# Notes for the future
- Add a way to define the book's icon
- Add a way for players to make books like these
- Add a way to make books that are just one page
- Add images to books
- Add a way to make books that are just images


