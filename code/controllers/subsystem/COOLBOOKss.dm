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
	/// Not actually used by anything, just a cool list of cool images for cool logging purposes
	var/list/all_images = list()

/datum/controller/subsystem/cool_books/Initialize()
	var/boox = build_library()
	. = ..()
	to_chat(world, span_announce("Initialized [boox] COOLBOOK(s), with [LAZYLEN(all_images)] pictures!"))

/datum/controller/subsystem/cool_books/proc/force_refresh()
	/// BURN EM, BURN EM ALL
	QDEL_LIST_ASSOC_VAL(all_books)
	all_images.Cut()
	/// Then immediately rewrite them
	var/boox = build_library()
	message_admins("COOLBOOK library has been refreshed! [boox] COOLBOOK(s) loaded, with [LAZYLEN(all_images)] pictures!")

/// Runs through the cool_books/ directory and compiles all the JSONs into datum/cool_book
/datum/controller/subsystem/cool_books/proc/build_library()
	/// First, gather up all the directories in cool_books/
	/// Also filters out anything that isnt a subdirectory
	var/list/all_book_directories = flist("[BOOKS_DIRECTORY]")
	var/number_of_books = 0
	for(var/hardcover in all_book_directories)
		// if(findtext(hardcover, BOOKS_DIRECTORY_IMAGES))
		// 	all_book_directories -= hardcover // found an image! not a directory!
		// 	continue // While you can put images in here, they won't be read by the system
		if(findtext(hardcover, ".")) // If it has a period, it's a file, likely a readme or something
			all_book_directories -= hardcover // found a file! not a directory!
			continue // While you can put files in here, they won't be read by the system
		if(!fexists("[BOOKS_DIRECTORY][hardcover]/[BOOK_INDEX]")) // no index? it isnt a book!
			all_book_directories -= hardcover // found a directory without an index! not a book!
			continue
	if(!LAZYLEN(all_book_directories))
		return // just so the fuckin checks pass
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
	data["BookCover"] = book.cover
	data["BookDirectory"] = book.book_directory
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
	var/list/top_image = book.get_top_image(chapter, page)
	var/list/bottom_image = book.get_bottom_image(chapter, page)
	data["TopImage"] = LAZYACCESS(top_image, BOOK_IMG_DATA_FILENAME)
	data["TopImageResize"] = LAZYACCESS(top_image, BOOK_IMG_DATA_RESIZE)
	data["TopImageIsURL"] = LAZYACCESS(top_image, BOOK_IMG_DATA_ISURL)
	data["BottomImage"] = LAZYACCESS(bottom_image, BOOK_IMG_DATA_FILENAME)
	data["BottomImageResize"] = LAZYACCESS(bottom_image, BOOK_IMG_DATA_RESIZE)
	data["BottomImageIsURL"] = LAZYACCESS(bottom_image, BOOK_IMG_DATA_ISURL)
	data["CanNext"] = (!isindex && page < max_pages)
	data["CanPrev"] = (!isindex && page > 1)
	data["IsPlayerMade"] = book.playermade
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

/datum/controller/subsystem/cool_books/proc/add_image_tally(cool_pic_path)
	// if(!fexists(cool_pic_path))
	// 	CRASH("add_image_tally() called with a path that doesn't exist! Path was [cool_pic_path]!")
	LAZYADD(all_images, cool_pic_path)

/////////////////////////////////////////////////////////////////////////////////
/// Our COOLBOOK datum
/datum/cool_book
	/// Key by which this darn thing is pulled from the librawry
	var/key
	/// The root directory of this book
	var/book_directory
	/// The title of the book
	var/title
	/// The description of the book
	var/desc
	/// The icon state of the book
	var/cover
	/// The author of the book
	var/author
	/// Is the book player-made? If so, sanitize the FUCK out of it
	var/playermade
	/// The pages in this book
	/// Format: list("chapter_key" = [/datum/cool_book_page], ...")
	var/list/chapters = list()

/datum/cool_book/New(book_directory)
	. = ..()
	src.book_directory = book_directory
	if(!build_book(book_directory))
		qdel(src)
		CRASH("COOLBOOK [book_directory] failed to load!")

/datum/cool_book/Destroy(force, ...)
	QDEL_LIST_ASSOC_VAL(chapters)
	. = ..()

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
	chapters = sort_list(chapters, /datum/cool_book/proc/cmp_chapter_order) // bit of a mouthful, so open wide
	chapters = invert_ass_list(chapters) // I swear this'll make sense later
	return TRUE

/datum/cool_book/proc/cmp_chapter_order(datum/cool_chapter/chapter1, datum/cool_chapter/chapter2)
	if(!istype(chapter1) || !istype(chapter2))
		CRASH("cmp_chapter_order() called with a null chapter!")
	if(chapter1.order == chapter2.order)
		return sorttext(chapter1.book_directory, chapter2.book_directory)
	return (chapter1.order > chapter2.order) ? 1 : -1

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
	chapters[chapter] = chapter.chapter_title // it'll make sense in a bit, bear with me
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
	cover = LAZYACCESS(chapter_data, BOOKENTRY_COVER)
	if(!cover)
		cover = "book1"
	author = LAZYACCESS(chapter_data, BOOKENTRY_AUTHOR)
	if(!author)
		author = "Alan Smithee"
	playermade = LAZYACCESS(chapter_data, BOOKENTRY_PLAYERMADE)
	return TRUE

/datum/cool_book/proc/get_text(find_chapter = BOOK_CHAPTER_INDEX, page = 1)
	var/datum/cool_chapter/chapter = LAZYACCESS(chapters, find_chapter)
	if(!chapter)
		stack_trace("COOLBOOK [key] has no chapter [find_chapter]!")
		return "This page (un)intentionally left blank."
	return chapter.get_text(page)

/datum/cool_book/proc/get_chapter_list(include_index = FALSE)
	var/list/chapter_list = list()
	for(var/chapter in chapters)
		if(chapter == BOOK_CHAPTER_INDEX && !include_index)
			continue
		chapter_list += chapter
	return chapter_list

/datum/cool_book/proc/get_chapter_titles()
	var/list/chapter_titles = list()
	for(var/chapter in chapters)
		var/datum/cool_chapter/chaptie = LAZYACCESS(chapters, chapter)
		if(!chaptie)
			stack_trace("COOLBOOK [key] has a chapter that does not exist! [chapter]")
			continue
		if(chaptie.chapter_title)
			chapter_titles += chaptie.chapter_title
		else
			stack_trace("COOLBOOK [key] has a chapter with no title! [chaptie]")
			chapter_titles += "Untitled Chapter [chapters.Find(chaptie)]"
	return chapter_titles

/datum/cool_book/proc/get_max_pages(find_chapter = BOOK_CHAPTER_INDEX)
	if(!find_chapter || find_chapter == BOOK_CHAPTER_INDEX)
		return 1
	var/datum/cool_chapter/chapter = LAZYACCESS(chapters, find_chapter)
	if(!chapter)
		stack_trace("COOLBOOK [key] has no chapter [find_chapter]!")
		return 1
	return LAZYLEN(chapter.pages)

/datum/cool_book/proc/get_top_image(chapter, page)
	var/datum/cool_chapter/chaptie = LAZYACCESS(chapters, chapter)
	if(!chaptie)
		stack_trace("COOLBOOK [key] has no chapter [chaptie]!")
		return
	return chaptie.get_top_image(page)

/// yeah its the same as get_top_image, refactor it if it bothers you =3
/datum/cool_book/proc/get_bottom_image(chapter, page)
	var/datum/cool_chapter/chaptie = LAZYACCESS(chapters, chapter)
	if(!chaptie)
		stack_trace("COOLBOOK [key] has no chapter [chaptie]!")
		return
	return chaptie.get_bottom_image(page)

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
	/// The root path to the book this is in
	var/book_directory
	/// The title of the chapter
	var/chapter_title
	/// The top images
	var/list/top_images
	/// The bottom images
	var/list/bottom_images
	/// Is this our index?
	var/is_index = FALSE
	/// What order should this appear in the book?
	var/order = 0 // conflicts will be ordered by name, maybe
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
	book_directory = mybook.book_directory
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
		if(findtext(line, BOOK_TXT_IMG_TOP)) // time to run this fucker a bunch of times =3
			extract_txt_img(line, BOOK_TXT_IMG_TOP)
			continue
		if(findtext(line, BOOK_TXT_IMG_BOTTOM))
			extract_txt_img(line, BOOK_TXT_IMG_BOTTOM)
			continue
		if(findtext(line, BOOK_TXT_ORDER_TOKEN))
			extract_txt_order(line)
			continue // dont include that
		text_out += line
	if(!LAZYLEN(text_out))
		text_out += "This chapter (un)intentionally left blank."
		stack_trace("Chapter [chapter_path] has a txt chapter that lacks any text!")
	if(!chapter_title)
		chapter_title = "Untitled Chapter [rand(1000,9999)]-[rand(1000,9999)]-[rand(1000,9999)]"
		stack_trace("Chapter [chapter_path] has a txt chapter that lacks a chapter title! Making one up! [chapter_title]")
	return pagify(text_out)

/// Extracts an image from a txt file
/// just like teeth
/datum/cool_chapter/proc/extract_txt_img(line, token)
	if(!line || !token)
		return
	/// should be a breeze with regex. Too bad I dont know regex!
	var/where_split = findtext(line, ":") // everything after the colon is the filename
	if(!where_split)
		return
	var/img_filename = copytext(line, where_split + 1, length(line) + 1)
	if(!img_filename)
		return
	line = copytext(line, 1, where_split - 1) // everything before the colon is metadata
	var/img_scalemode
	if(findtext(line, BOOK_IMG_FLAG_STRETCH))
		img_scalemode = BOOK_IMG_FLAG_STRETCH
	else
		img_scalemode = BOOK_IMG_FLAG_FIT
	var/isurl = FALSE
	if(findtext(line, BOOK_IMG_URL)) // Our image is actually a URL (hopefully) pointing to (hopefully) an image (hopefully)
		isurl = TRUE
	var/lsb = findtext(line, "<") // to the left of the pagenumber
	var/pipe = findtext(line, "|") // to the right of the pagenumber
	var/img_page = copytext(line, lsb+1, pipe) // am smart
	var/img_page_num = text2num(img_page)
	if(!register_image(img_filename, img_scalemode, img_page_num, token, isurl)) // images in react are wierd
		log_world("Chapter [chapter_title] has a txt chapter with an image that failed to register! [img_filename] [img_scalemode] [img_page_num] [token] [isurl]")

/// Extracts the order of a chapter from a txt file
/datum/cool_chapter/proc/extract_txt_order(line)
	if(!line)
		return
	var/where_split = findtext(line, ":") // everything after the colon is the order number. will be a string tho
	if(!where_split)
		return
	line = copytext(line, where_split + 1, length(line) + 1) // everything before the colon is metadata
	var/order_num = text2num(line)
	if(!order_num)
		return
	order = order_num

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
	extract_json_img(jsoncontents)
	extract_json_order(jsoncontents)
	var/list/text_out = LAZYACCESS(jsoncontents, BOOK_CHAPTER_JSON_CONTENT)
	if(!LAZYLEN(text_out))
		text_out += "This chapter (un)intentionally left blank."
		stack_trace("Chapter [chapter_path] has a json chapter that lacks any text!")
	return pagify(text_out)

/// Extracts the images from a json file
/// Thankfully much easier
/datum/cool_chapter/proc/extract_json_img(list/jsoncontents)
	if(!LAZYLEN(jsoncontents))
		return
	var/list/img_places = list()
	if(LAZYACCESS(jsoncontents, BOOK_CHAPTER_JSON_TOP_IMAGES))
		img_places += BOOK_CHAPTER_JSON_TOP_IMAGES
	if(LAZYACCESS(jsoncontents, BOOK_CHAPTER_JSON_BOTTOM_IMAGES))
		img_places += BOOK_CHAPTER_JSON_BOTTOM_IMAGES
	if(!LAZYLEN(img_places))
		return
	for(var/img_place in img_places)
		/// format: list("1" = list("image" = "mydick.png", "scalemode" = "fit))
		var/list/which_section = LAZYACCESS(jsoncontents, img_place)
		if(!LAZYLEN(which_section))
			continue
		for(var/img_page in which_section)
			var/list/inner_list = LAZYACCESS(which_section, img_page)
			if(!LAZYLEN(inner_list))
				continue
			var/img_filename = LAZYACCESS(inner_list, BOOK_IMG_DATA_FILENAME)
			if(!img_filename)
				continue
			var/img_scalemode = LAZYACCESS(inner_list, BOOK_IMG_DATA_RESIZE)
			if(!img_scalemode)
				img_scalemode = BOOK_IMG_FLAG_FIT
			var/isurl = LAZYACCESS(inner_list, BOOK_IMG_URL)
			if(!register_image(img_filename, img_scalemode, img_page, img_place, isurl)) // images in react are wierd
				log_world("Chapter [src] has a json chapter with an image that failed to register! [img_filename] [img_scalemode] [img_page] [img_place] [isurl]")
				continue
			. = TRUE

/// Extracts the order of a chapter from a json file
/datum/cool_chapter/proc/extract_json_order(list/jsoncontents)
	if(!LAZYLEN(jsoncontents))
		return
	var/order_num = LAZYACCESS(jsoncontents, BOOK_CHAPTER_JSON_ORDER)
	if(!order_num)
		return
	order = order_num

/// Registers an image to a page
/// This is a bit of a mess, but it works
/datum/cool_chapter/proc/register_image(img_filename, img_scalemode = "fit", img_page = 1, topbottom = BOOK_TXT_IMG_TOP, isurl = FALSE)
	var/img_fullpath
	if(!isurl)
		img_fullpath = "[COOLBOOK_IMG_SRC_DIR][img_filename]"
		if(!fexists(img_fullpath))
			log_world("Chapter [src] has a chapter with an image that does not exist! [img_filename] [img_fullpath]")
			return FALSE
		SSassets.transport.register_asset(img_filename, img_fullpath)
	else 
		img_fullpath = img_filename
		if(!check_img_url(img_filename))
			CRASH("Chapter [src] has a chapter with an image URL that is not a valid URL! [img_filename]")
	var/list/img_data = list()
	img_data[BOOK_IMG_DATA_FILENAME] = img_filename
	img_data[BOOK_IMG_DATA_RESIZE] = img_scalemode
	img_data[BOOK_IMG_DATA_ISURL] = isurl
	switch(topbottom)
		if(BOOK_TXT_IMG_TOP, BOOK_CHAPTER_JSON_TOP_IMAGES)
			LAZYSET(top_images, "[img_page]", img_data)
		if(BOOK_TXT_IMG_BOTTOM, BOOK_CHAPTER_JSON_BOTTOM_IMAGES) // TOP TEXT BOTTOM TEXT INSANITY WOLF
			LAZYSET(bottom_images, "[img_page]", img_data)
		else
			CRASH("Chapter [src] has a chapter with an image that is not a top or bottom image! (NO SWITCHES!!!) [img_filename]")
	SScool_books.add_image_tally(img_fullpath)
	return TRUE

/datum/cool_chapter/proc/check_img_url(img_fullpath)
	for(var/prefix in BOOK_IMG_URL_PREFIXES)
		if(!findtext(img_fullpath, prefix))
			continue
		for(var/suffix in BOOK_IMG_URL_SUFFIXES)
			if(findtext(img_fullpath, suffix))
				return TRUE

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
			current_page += "\n \n" // blank lines are treated as a full line break
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

/datum/cool_chapter/proc/get_top_image(page = 1)
	if(is_index)
		page = 1
	page = clamp(page, 1, LAZYLEN(pages))
	var/list/img_data = LAZYACCESS(top_images, "[page]")
	return img_data

/// Again, refactor if it bothers you :D
/datum/cool_chapter/proc/get_bottom_image(page = 1)
	if(is_index)
		page = 1
	page = clamp(page, 1, LAZYLEN(pages))
	var/list/img_data = LAZYACCESS(bottom_images, "[page]")
	return img_data
