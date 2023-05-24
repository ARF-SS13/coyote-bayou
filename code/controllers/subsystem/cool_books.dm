/// A subsystem for compiling a huge database of book entries
/* 
 * So this is a subsystem for compiling a huge database of book entries
 * It reads every JSON in [cool_books/] and transcribes them into a system of datum/cool_book
 * They'll be loaded automatically! By flist! That's cool!
 */

SUBSYSTEM_DEF(cool_books)
	name = "Books"
	flags = SS_BACKGROUND|SS_NO_FIRE
	wait = 1 SECONDS

	/// The list of cool_book datums
	/// Format: list("key" = [/datum/cool_book], ...)
	var/list/all_books = list()

/datum/controller/subsystem/cool_books/Initialize()
	var/boox = build_library()
	. = ..()
	to_chat(world, span_announce("Initialized [boox] cool_books entries!"))

/// Runs through the cool_books/ directory and compiles all the JSONs into datum/cool_book
/datum/controller/subsystem/cool_books/proc/build_library()
	/// First, gather up all the directories in cool_books/
	/// Also filters out anything that isnt a subdirectory
	var/list/all_book_directories = flist("[BOOKS_DIRECTORY]")
	var/number_of_books = 0
	for(var/hardcover in all_book_directories)
		if(findtext(hardcover, ".")) // If it has a period, it's a file, likely a readme or something
			all_book_directories -= hardcover // found a file! not a directory!
			continue // While you can put files in here, they won't be read by the system
	/// Now we have a list of all the directories in cool_books/
	/// Let's go through them and compile whats inside into datum/cool_book
	for(var/realbook in all_book_directories)
		if(build_book("[BOOKS_DIRECTORY][realbook]"))
			number_of_books++
	return number_of_books

/datum/controller/subsystem/cool_books/proc/build_book(book_directory)
	if(!book_directory)
		CRASH("build_book() called with no book_directory!")
	if(!fexists("[book_directory][BOOK_INDEX]"))
		CRASH("Book index.json file for [book_directory] does not exist!")
	var/list/book_index_contents = safe_json_decode("[book_directory][BOOK_INDEX]")
	if(!LAZYLEN(book_index_contents))
		CRASH("Book index.json file for [book_directory] is empty!")
	var/datum/cool_book/book = new(book_index_contents)
	var/list/chapters = flist("[book_directory]")
	chapters -= "[book_directory][BOOK_INDEX]" // already got this one
	if(!LAZYLEN(chapters))
		CRASH("Book [book_directory] has no chapters! Just an index.json file!")
	/// Now, run through all the files in the book directory and compile them into the book
	/// Do note, the files can be either JSON or text files, whichever Fenny feels like =3
	for(var/coolchapter in chapters)
		book.add_chapter(coolchapter)
	/// Now, add the book to the list of cool_books
	add_to_library(book)

/datum/controller/subsystem/cool_books/proc/add_to_library(datum/cool_book/my_book)
	if(!my_book)
		CRASH("add_to_library() called with no book!")
	if(!istype(my_book, /datum/cool_book))
		CRASH("add_to_library() called with something that isn't a book!")
	if(!my_book.key)
		CRASH("add_to_library() called with a book that has no key!")
	all_books[my_book.key] = my_book

/datum/controller/subsystem/cool_books/proc/get_book(key)
	if(!key)
		CRASH("get_book() called with no key!")
	var/datum/cool_book/book = all_books[key]
	if(!book)
		CRASH("cool_books entry '[key]' does not exist!")
	return book

/datum/controller/subsystem/cool_books/proc/format_book_for_tgui(key)
	var/datum/cool_book/book = get_book(key)
	if(!book)
		CRASH("format_book_for_tgui() called with a key that isn't a book! Key was [key]!")
	var/list/data = list()
	data["book_title"] = book.title
	data["book_author"] = book.author
	data["book_desc"] = book.desc
	data["book_text"] = book.get_text()
	data["book_chapters"] = book.get_chapter_list()
	
	data["amount"] = amount
	
	//data["energy"] = cell.charge ? cell.charge * powerefficiency : "0" //To prevent NaN in the UI.
	//data["maxEnergy"] = cell.maxcharge * powerefficiency
	data["cartridgeCharge"] = cartridge.charge ? cartridge.charge * matefficiency : "0"
	data["maxCartridgeCharge"] = cartridge.maxCharge * matefficiency
	data["isBeakerLoaded"] = beaker ? 1 : 0


/// Our cool book
/datum/cool_book
	/// Key by which this darn thing is pulled from the librawry
	var/key
	/// The title of the book
	var/title
	/// The description of the book
	var/desc
	/// The author of the book
	var/author
	/// The main text in this book, between the header and the table of contents
	var/list/text
	/// The pages in this book
	/// Format: list("chapter_key" = [/datum/cool_book_page], ...")
	var/list/chapters = list()

/datum/cool_book/New(list/index_file)
	if(!LAZYLEN(index_file))
		CRASH("Attempted to create a book with an empty index!")
	key = LAZYACCESS(index_file, BOOKENTRY_KEY)
	if(!key)
		CRASH("Attempted to create a book with an empty key!")
	title = LAZYACCESS(index_file, BOOKENTRY_TITLE)
	if(!title)
		stack_trace("Book [key] lacks a title!")
		title = "Untitled Book"
	desc = LAZYACCESS(index_file, BOOKENTRY_DESCRIPTION)
	if(!desc)
		stack_trace("Book [key] lacks a description!")
		desc = "Its contents are a mystery! Until you open it though."
	author = LAZYACCESS(index_file, BOOKENTRY_AUTHOR)
	if(!author)
		stack_trace("Book [key] lacks an author!")
		author = "Alan Smithee"
	text = LAZYACCESS(index_file, BOOKENTRY_TEXT)
	return TRUE

/datum/cool_book/proc/get_text()
	return jointext(text, "<br>")

/datum/cool_book/proc/get_chapter_list()
	var/list/chapter_list = list()
	for(var/chapter in chapters)
		chapter_list += chapter.chapter_title
	return chapter_list

/datum/cool_book/proc/add_chapter(chapter_path)
	if(!fexists("[chapter_path]"))
		CRASH("Book [key] has a chapter that does not exist! [chapter_path]")
	var/datum/cool_book_chapter/chapter = new(chapter_path, key)
	if(!chapter)
		CRASH("Book [key] has a chapter that failed to compile! [chapter_path]")
	chapters[chapter.chapter_title] = chapter

/// A chapter in our cool book
/// Created from a txt file in the book directory
/// Pages are added either manually with a --PAGEBREAK-- tag, or automatically if the page is too long
/datum/cool_book_chapter
	/// The key to the book this is in
	var/book_key
	/// The title of the page
	var/chapter_title
	/// The pages in this chapter
	/// Format: list(1 = list("line","line","line"), ...")
	var/list/pages
	/// automatic page breaks
	var/automatic_page_breaks = FALSE

/datum/cool_book_chapter/New(chapter_path, owner_key)
	if(!chapter_path)
		stack_trace("Attempted to create a chapter with an empty path!")
		qdel(src)
	if(!owner_key)
		stack_trace("Attempted to create a chapter with an empty owner key! [chapter_path]")
		qdel(src)
	book_key = owner_key
	if(findtext(chapter_path, ".txt"))
		read_txt(chapter_path)
	else if(findtext(chapter_path, ".json"))
		read_json(chapter_path)
	else
		stack_trace("Book [chapter_key] has a chapter that is not a .txt or .json file! [chapter_path]")
		qdel(src)

/// If our chapter is a txt file, read through and parse out the pesudometadata
/// You can find the valid TXT tokens in [code\__DEFINES\cool_books.dm]
/datum/cool_book/proc/read_txt(chapter_path)
	var/list/txtcontents = file2list(chapter_path)
	if(!LAZYLEN(txtcontents))
		CRASH("Chapter [chapter_path] has a txt chapter that is empty! [chapter_path]")
	var/list/text_out
	automatic_page_breaks = TRUE
	for(var/line in txtcontents)
		if(!chapter_title && findtext(line, BOOK_CHAPTER_TXT_TOKEN_TITLE))
			chapter_title = replacetext(line, BOOK_CHAPTER_TXT_TOKEN_TITLE, "")
			continue
		if(automatic_page_breaks && findtext(line, BOOK_CHAPTER_TOKEN_PAGEBREAK))
			automatic_page_breaks = FALSE
			continue
		text_out += line
	if(!LAZYLEN(txt_out))
		text_out += "This chapter (un)intentionally left blank."
		stack_trace("Chapter [chapter_path] has a txt chapter that lacks any text!")
	if(!chapter_title)
		chapter_title = "Untitled Chapter [rand(1000,9999)]-[rand(1000,9999)]-[rand(1000,9999)]"
		stack_trace("Chapter [chapter_path] has a txt chapter that lacks a chapter title! Making one up! [chapter_title]")
	return pagify(text_out)

/// If our chapter is a json, we just yoink out the data easy as
/datum/cool_book/proc/read_json(chapter_path)
	var/list/jsoncontents = safe_json_decode(chapter_path)
	if(!LAZYLEN(jsoncontents))
		CRASH("Chapter [chapter_path] has a json chapter that is empty! [chapter_path]")
	chapter_title = LAZYACCESS(jsoncontents, BOOK_CHAPTER_JSON_TITLE)
	if(!chapter_title)
		chapter_title = "Untitled Chapter [rand(1000,9999)]-[rand(1000,9999)]-[rand(1000,9999)]"
		stack_trace("Chapter [chapter_path] has a json chapter that lacks a chapter title! Making one up! [chapter_title]")
	if(LAZYACCESS(jsoncontents, BOOK_CHAPTER_JSON_IGNORE_AUTOMATIC_PAGE_BREAK) == TRUE)
		automatic_page_breaks = TRUE
	var/list/text_out = LAZYACCESS(jsoncontents, BOOK_CHAPTER_JSON_CONTENT)
	if(!LAZYLEN(text_out))
		text_out += "This chapter (un)intentionally left blank."
		stack_trace("Chapter [chapter_path] has a json chapter that lacks any text!")
	return pagify(text_out)

/datum/cool_book_chapter/proc/pagify(list/my_content)
	LAZYINITLIST(pages)
	var/list/current_page = list()
	for(var/line in my_content)
		if((automatic_page_breaks && LAZYLEN(current_page) >= BOOK_CHAPTER_MAX_LINES_PER_PAGE) || findtext(line, BOOK_CHAPTER_TXT_TOKEN_PAGE))
			if(!LAZYLEN(current_page))
				current_page += "This page (un)intentionally left blank."
			LAZYADD(pages, current_page)
			current_page.Cut()
			continue
		current_page += line
	return TRUE


