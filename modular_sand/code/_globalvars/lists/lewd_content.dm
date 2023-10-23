/*
 * List of clothes with possible peeking under,
 * It is prefilled with clothes that cannot be caught
 * by the automatic system (has no skirt in path)
*/

GLOBAL_LIST_INIT(skirt_peekable, list()))

/*
 * List of clothes you can't say a pair of.
 * Ex:
 * A pair of jockstrap?
*/
GLOBAL_LIST_INIT(pairless_panties, list())
