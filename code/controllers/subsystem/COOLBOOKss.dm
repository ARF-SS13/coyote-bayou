/* 
 * So this is a subsystem for compiling a huge database of COOLBOOK entries
 * It reads every JSON in [cool_books/] and transcribes them into a system of datum/cool_book
 * They'll be loaded automatically! By flist! That's cool!
 */

SUBSYSTEM_DEF(cool_books)
	name = "COOLBOOK" // Hey, cool book, bro!
	flags = SS_BACKGROUND|SS_NO_FIRE
	init_order = INIT_ORDER_SOUNDS

	/// The list of cool_book datums
	/// Format: list("key" = [/datum/cool_book], ...)
	var/list/all_books = list()

/datum/controller/subsystem/cool_books/Initialize()
	var/boox = build_library()
	. = ..()
	to_chat(world, span_announce("Initialized [boox] COOLBOOK(s)!"))

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
	var/datum/cool_book/book = new("[book_directory]")
	if(!book)
		CRASH("COOLBOOK [book_directory] failed to load!")
	/// Now, add the book to the list of cool_books
	return add_to_library(book)

/datum/controller/subsystem/cool_books/proc/add_to_library(datum/cool_book/my_book)
	if(!my_book)
		CRASH("add_to_library() called with no book!")
	if(!istype(my_book, /datum/cool_book))
		CRASH("add_to_library() called with something that isn't a book!")
	if(!my_book.key)
		CRASH("add_to_library() called with a book that has no key!")
	all_books[my_book.key] = my_book
	return TRUE

/datum/controller/subsystem/cool_books/proc/get_book(key)
	if(!key)
		CRASH("get_book() called with no key!")
	var/datum/cool_book/book = all_books[key]
	if(!book)
		CRASH("cool_books entry '[key]' does not exist!")
	return book

/datum/controller/subsystem/cool_books/proc/format_book_for_tgui(key, chapter = BOOK_CHAPTER_INDEX, page = 1)
	var/datum/cool_book/book = get_book(key)
	if(!book)
		CRASH("format_book_for_tgui() called with a key that isn't a book! Key was [key]!")
	if(!chapter || !book.has_chapter(chapter))
		if(!book.has_chapter(BOOK_CHAPTER_INDEX))
			CRASH("format_book_for_tgui() called not only with a chapter that doesn't exist, but a book without an index! Holy shit! Chapter was [chapter]!")
		chapter = BOOK_CHAPTER_INDEX // i swear if it doesnt have an index imma cry
	var/max_pages = book.get_max_pages(chapter)
	page = clamp(page, 1, max_pages) // clamp it to the limit, the limiiit
	var/list/data = list()
	data["BookTitle"] = book.title
	data["BookAuthor"] = book.author
	data["BookDesc"] = book.desc
	var/list/all_chapters = book.get_chapter_list()
	data["AllChapters"] = all_chapters
	var/list/all_chapter_titles = book.get_chapter_titles()
	data["AllChapterTitles"] = all_chapter_titles
	data["CurrentChapter"] = chapter
	data["CurrentChapterTitle"] = chapter
	var/isindex = book.is_index(chapter)
	data["IsIndex"] = isindex
	data["PageText"] = book.get_text(chapter, page)
	data["PageNumber"] = page
	data["PageTotal"] = max_pages
	data["CanNext"] = (!isindex && page < max_pages)
	data["CanPrev"] = (!isindex && page > 1)
	return data

/datum/controller/subsystem/cool_books/proc/get_max_pages(book_key, chapter = BOOK_CHAPTER_INDEX)
	if(!book_key)
		CRASH("Invalid book_key!")
	if(!chapter)
		CRASH("Invalid chapter for [book_key]!")
	var/datum/cool_book/mybook = get_book(book_key)
	if(!mybook)
		CRASH("Book [book_key] does not exist!")
	return mybook.get_max_pages(chapter)

/////////////////////////////////////////////////////////////////////////////////
/// Our COOLBOOK datum
/datum/cool_book
	/// Key by which this darn thing is pulled from the librawry
	var/key
	/// The title of the book
	var/title
	/// The description of the book
	var/desc
	/// The author of the book
	var/author
	/// The pages in this book
	/// Format: list("chapter_key" = [/datum/cool_book_page], ...")
	var/list/chapters = list()

/datum/cool_book/New(book_directory)
	. = ..()
	if(!build_book(book_directory))
		qdel(src)
		CRASH("COOLBOOK [book_directory] failed to load!")

/datum/cool_book/proc/build_book(book_directory)
	if(!book_directory)
		CRASH("build_book() called with no book_directory!")
	if(!fexists("[book_directory][BOOK_INDEX]"))
		CRASH("COOLBOOK index.json file for [book_directory] does not exist!")
	var/list/chapter_files = flist("[book_directory]")
	if(!LAZYLEN(chapter_files))
		CRASH("COOLBOOK [book_directory] has no usable chapter files!")
	/// Now run through all the files in the directory, check if they're valid, and add them to the book
	/// Do note, the files can be either JSON or text files, whichever Fenny feels like =3
	for(var/coolchapter in chapter_files)
		if(!is_valid_chapter_file("[book_directory][coolchapter]"))
			continue // Not a problem if it's not a valid chapter file, just ignore it
		if(!add_chapter("[book_directory][coolchapter]"))
			stack_trace("COOLBOOK [book_directory] chapter [coolchapter] failed to load!")
	return TRUE

/datum/cool_book/proc/is_valid_chapter_file(full_file_path)
	if(!full_file_path)
		return FALSE
	if(!fexists(full_file_path))
		return FALSE
	if(!findtext(full_file_path, ".json") && !findtext(full_file_path, ".txt"))
		return FALSE
	return TRUE

/datum/cool_book/proc/add_chapter(chapter_path)
	if(!fexists("[chapter_path]"))
		CRASH("COOLBOOK [key] has a chapter that does not exist! [chapter_path]")
	var/datum/cool_chapter/chapter = new(chapter_path, src)
	if(!chapter)
		CRASH("COOLBOOK [key] has a chapter that failed to compile! [chapter_path]")
	chapters[chapter.chapter_title] = chapter
	return TRUE

/datum/cool_book/proc/indexify(list/chapter_data)
	key = LAZYACCESS(chapter_data, BOOKENTRY_KEY)
	if(!key)
		CRASH("Attempted to create a book with an empty key!")
	title = LAZYACCESS(chapter_data, BOOKENTRY_TITLE)
	if(!title)
		title = "Untitled COOLBOOK"
	desc = LAZYACCESS(chapter_data, BOOKENTRY_DESCRIPTION)
	if(!desc)
		desc = "Its contents are a mystery! Until you open it though."
	author = LAZYACCESS(chapter_data, BOOKENTRY_AUTHOR)
	if(!author)
		author = "Alan Smithee"
	return TRUE

/datum/cool_book/proc/get_text(find_chapter = BOOK_CHAPTER_INDEX, page = 1)
	var/datum/cool_chapter/chapter = LAZYACCESS(chapters, find_chapter)
	if(!chapter)
		stack_trace("COOLBOOK [key] has no chapter [find_chapter]!")
		return "This page (un)intentionally left blank."
	return chapter.get_text(page)

/datum/cool_book/proc/get_chapter_list()
	var/list/chapter_list = list()
	for(var/chapter in chapters)
		chapter_list += chapter
	return chapter_list

/datum/cool_book/proc/get_chapter_titles()
	var/list/chapter_titles = list()
	for(var/datum/cool_chapter/chapter in chapters)
		if(chapter.chapter_title)
			chapter_titles += chapter.chapter_title
		else
			stack_trace("COOLBOOK [key] has a chapter with no title! [chapter]")
			chapter_titles += "Untitled Chapter [chapters.Find(chapter)]"
	return chapter_titles

/datum/cool_book/proc/get_max_pages(find_chapter = BOOK_CHAPTER_INDEX)
	if(!find_chapter || find_chapter == BOOK_CHAPTER_INDEX)
		return 1
	var/datum/cool_chapter/chapter = LAZYACCESS(chapters, find_chapter)
	if(!chapter)
		stack_trace("COOLBOOK [key] has no chapter [find_chapter]!")
		return 1
	return LAZYLEN(chapter.pages)

/datum/cool_book/proc/is_index(find_chapter = BOOK_CHAPTER_INDEX)
	if(!find_chapter || find_chapter == BOOK_CHAPTER_INDEX)
		return TRUE
	var/datum/cool_chapter/chapter = LAZYACCESS(chapters, find_chapter)
	if(!chapter)
		stack_trace("COOLBOOK [key] has no index chapter [find_chapter]!")
		return TRUE
	return chapter.is_index

/datum/cool_book/proc/has_chapter(chapter)
	return LAZYACCESS(chapters, chapter)

/////////////////////////////////////////////////////////////////////////////////
/// A chapter in our cool book
/// Created from a txt file in the book directory
/// Pages are added either manually with a --PAGEBREAK-- tag, or automatically if the page is too long
/datum/cool_chapter
	/// The key to the book this is in
	var/book_key
	/// The title of the chapter
	var/chapter_title
	/// Is this our index?
	var/is_index = FALSE
	/// The pages in this chapter
	/// Format: list(1 = "fuckhuge block of text", ...")
	var/list/pages
	/// automatic page breaks
	var/automatic_page_breaks = FALSE

/datum/cool_chapter/New(chapter_path, datum/cool_book/mybook)
	if(!chapter_path)
		stack_trace("Attempted to create a chapter with an empty path!")
		qdel(src)
	if(!fexists(chapter_path))
		stack_trace("Attempted to create a chapter with a nonexistant file!")
		qdel(src)
	if(!mybook)
		stack_trace("Attempted to create a chapter with a nonexistent book! [chapter_path]")
		qdel(src)
	book_key = mybook.key
	if(findtext(chapter_path, ".txt"))
		read_txt(chapter_path, mybook)
	else if(findtext(chapter_path, ".json"))
		read_json(chapter_path, mybook)
	else
		stack_trace("COOLBOOK [mybook.key] has a chapter that is not a .txt or .json file! [chapter_path]")
		qdel(src)

/// If our chapter is a txt file, read through and parse out the pesudometadata
/// You can find the valid TXT tokens in [code\__DEFINES\cool_books.dm]
/datum/cool_chapter/proc/read_txt(chapter_path)
	var/list/txtcontents = world.file2list(chapter_path, trim = FALSE)
	if(!LAZYLEN(txtcontents))
		CRASH("Chapter [chapter_path] has a txt chapter that is empty! [chapter_path]")
	var/list/text_out = list()
	automatic_page_breaks = TRUE
	for(var/line in txtcontents)
		if(!chapter_title && findtext(line, BOOK_CHAPTER_TXT_TOKEN_TITLE))
			chapter_title = replacetext(line, BOOK_CHAPTER_TXT_TOKEN_TITLE, "")
			continue
		if(automatic_page_breaks && findtext(line, BOOK_CHAPTER_TOKEN_PAGEBREAK))
			automatic_page_breaks = FALSE
			continue
		text_out += line
	if(!LAZYLEN(text_out))
		text_out += "This chapter (un)intentionally left blank."
		stack_trace("Chapter [chapter_path] has a txt chapter that lacks any text!")
	if(!chapter_title)
		chapter_title = "Untitled Chapter [rand(1000,9999)]-[rand(1000,9999)]-[rand(1000,9999)]"
		stack_trace("Chapter [chapter_path] has a txt chapter that lacks a chapter title! Making one up! [chapter_title]")
	return pagify(text_out)

/// If our chapter is a json, we just yoink out the data easy as
/// Also handles defining an index as our index, since indexes are both chapters, and jsons.
/datum/cool_chapter/proc/read_json(chapter_path, datum/cool_book/mybook)
	var/cockstring = file2text(chapter_path)
	var/list/jsoncontents = safe_json_decode(cockstring)
	if(!LAZYLEN(jsoncontents))
		CRASH("Chapter [chapter_path] has a json chapter that is empty! [chapter_path]")
	if(LAZYACCESS(jsoncontents, BOOK_CHAPTER_JSON_AUTOPAGE) == TRUE)
		automatic_page_breaks = TRUE
	if(LAZYACCESS(jsoncontents, BOOK_CHAPTER_IS_INDEX) == TRUE)
		is_index = TRUE
		automatic_page_breaks = FALSE
		mybook.indexify(jsoncontents)
		chapter_title = BOOK_CHAPTER_INDEX
	else
		chapter_title = LAZYACCESS(jsoncontents, BOOK_CHAPTER_JSON_TITLE)
		if(!chapter_title)
			chapter_title = "Untitled Chapter [rand(1000,9999)]-[rand(1000,9999)]-[rand(1000,9999)]"
			stack_trace("Chapter [chapter_path] has a json chapter that lacks a chapter title! Making one up! [chapter_title]")
	var/list/text_out = LAZYACCESS(jsoncontents, BOOK_CHAPTER_JSON_CONTENT)
	if(!LAZYLEN(text_out))
		text_out += "This chapter (un)intentionally left blank."
		stack_trace("Chapter [chapter_path] has a json chapter that lacks any text!")
	return pagify(text_out)

/datum/cool_chapter/proc/pagify(list/my_content)
	LAZYINITLIST(pages)
	var/current_page = ""
	var/linecount = 0
	var/page_number = 1
	for(var/line in my_content)
		linecount++
		if(!is_index)
			if((automatic_page_breaks && linecount >= BOOK_PAGE_MAX_LINES) || findtext(line, BOOK_CHAPTER_TOKEN_PAGEBREAK))
				if(!LAZYLEN(current_page))
					current_page += "This page (un)intentionally left blank."
				LAZYSET(pages, "[page_number]", "[current_page]")
				current_page = ""
				linecount = 0
				page_number++
				continue
		if(line == "")
			current_page += "<br><br>" // blank lines are treated as a full line break
			continue
		current_page += "[line] " // concat the line to the current page, with a space, so it looks nice
	if(current_page != "")
		LAZYSET(pages, "[page_number]", "[current_page]")
	return TRUE

/datum/cool_chapter/proc/get_text(page = 1)
	if(is_index)
		page = 1
	page = clamp(page, 1, LAZYLEN(pages))
	var/text_out = LAZYACCESS(pages, "[page]")
	if(!text_out || text_out == "")
		stack_trace("Chapter [chapter_title] has no page [page]!")
		return "This page (un)intentionally left blank."
	return text_out
