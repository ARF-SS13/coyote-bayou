#define BOOKS_DIRECTORY "COOLBOOKs/"
#define BOOK_INDEX "index.json"

#define BOOKENTRY_KEY "key"
#define BOOKENTRY_DESC "desc"
#define BOOKENTRY_TITLE "title"
#define BOOKENTRY_AUTHOR "author"
#define BOOKENTRY_DESCRIPTION "desc"
#define BOOKENTRY_CONTENT "content"
#define BOOKENTRY_IMAGE "image"

/// If the chapter file is a txt file, this token is used to indicate the title of the chapter
/// Dont put a space after the colon, it will be included in the title
#define BOOK_CHAPTER_TXT_TOKEN_TITLE "%TITLE:"

/// These are keys of the json file, if the chapter file is a json file
#define BOOK_CHAPTER_JSON_TITLE "title"
#define BOOK_CHAPTER_JSON_CONTENT "content"
#define BOOK_CHAPTER_INDEX "index"
#define BOOK_CHAPTER_IS_INDEX "is_index"
/// Set this to true if you want the chapter to be automatically split into pages
/// Otherwise you'll have to manually put page breaks in the chapter file
#define BOOK_CHAPTER_JSON_AUTOPAGE "autopage"

/// Put this token as a line in either the txt or json file to indicate a page break
/// nothing else in this line will be read
#define BOOK_CHAPTER_TOKEN_PAGEBREAK "--PAGEBREAK--"

#define BOOK_PAGE_MAX_LINES 20

