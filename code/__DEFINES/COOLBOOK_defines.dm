#define BOOKS_DIRECTORY "COOLBOOK_books/"
#define BOOKS_DIRECTORY_IMAGES "images/"
#define BOOK_INDEX "index.json"
#define COOLBOOK_IMG_DEST_DIR "tgui/public/coolbook_images/"
#define COOLBOOK_IMG_SRC_DIR "COOLBOOK_IMAGES/"

#define BOOKENTRY_KEY "key"
#define BOOKENTRY_DESC "desc"
#define BOOKENTRY_TITLE "title"
#define BOOKENTRY_AUTHOR "author"
#define BOOKENTRY_DESCRIPTION "desc"
#define BOOKENTRY_COVER "cover"
#define BOOKENTRY_CONTENT "content"
#define BOOKENTRY_IMAGE "image"
#define BOOKENTRY_PLAYERMADE "playermade"

/// If the chapter file is a txt file, this token is used to indicate the title of the chapter
/// Dont put a space after the colon, it will be included in the title
#define BOOK_CHAPTER_TXT_TOKEN_TITLE "%TITLE:"
/// A two-part token thing that wraps a page number, for displaying an image on a specific page
#define BOOK_TXT_IMG_TOP "%TOP_IMAGE<"
/// A two-part token thing that wraps a page number, for displaying an image on a specific page
#define BOOK_TXT_IMG_BOTTOM "%BOTTOM_IMAGE<"
/// Token Divider, image token goes after this
#define BOOK_TXT_IMG_DIVIDER "|"
/// The second part of the token
#define BOOK_TXT_IMG_END ">:"
/// The order this chapter should be in.
#define BOOK_TXT_ORDER_TOKEN "%ORDER:"

/// Image flags! These are used to indicate how an image should be scaled
/// By default, it will be scaled down to fit the allowed space, but not stretched
/// If you want to stretch it, use this flag
#define BOOK_IMG_FLAG_STRETCH "stretch"
/// If you want to scale it up to fit the allowed space, use this flag
#define BOOK_IMG_FLAG_FIT "fit"

/// These are keys of the json file, if the chapter file is a json file
#define BOOK_CHAPTER_JSON_TITLE "title"
#define BOOK_CHAPTER_JSON_CONTENT "content"
#define BOOK_CHAPTER_INDEX "index"
#define BOOK_CHAPTER_IS_INDEX "is_index"
#define BOOK_CHAPTER_JSON_ORDER "order"
/// Set this to true if you want the chapter to be automatically split into pages
/// Otherwise you'll have to manually put page breaks in the chapter file
#define BOOK_CHAPTER_JSON_AUTOPAGE "autopage"
// The json tag for the list of images to display at the top of the page
// CHeck out the format in the example book
#define BOOK_CHAPTER_JSON_TOP_IMAGES "top_images"
// The json tag for the list of images to display at the bottom of the page
// CHeck out the format in the example book
#define BOOK_CHAPTER_JSON_BOTTOM_IMAGES "bottom_images"
#define BOOK_IMG_DATA_FILENAME "image"
#define BOOK_IMG_DATA_RESIZE "resize"
#define BOOK_IMG_URL "URL"
#define BOOK_IMG_DATA_ISURL "is_url"

#define BOOK_IMG_URL_PREFIXES list("cdn.discordapp.com/", "media.tenor.com/") // yeah fuck it time to hotlink everything
#define BOOK_IMG_URL_SUFFIXES list("png", "jpg", "jpeg", "gif") // yup webp dont work

/// Put this token as a line in either the txt or json file to indicate a page break
/// nothing else in this line will be read
#define BOOK_CHAPTER_TOKEN_PAGEBREAK "--PAGEBREAK--"
/// 

#define BOOK_PAGE_MAX_LINES 20

