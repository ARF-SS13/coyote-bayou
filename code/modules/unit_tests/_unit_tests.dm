//include unit test files in this module in this ifdef

#if defined(UNIT_TESTS) || defined(SPACEMAN_DMM)

/// For advanced cases, fail unconditionally but don't return (so a test can return multiple results)
#define TEST_FAIL(reason) (Fail(reason || "No reason", __FILE__, __LINE__))

/// Asserts that a condition is true
/// If the condition is not true, fails the test
#define TEST_ASSERT(assertion, reason) if (!(assertion)) { return Fail("Assertion failed: [reason || "No reason"]") }

/// Asserts that the two parameters passed are equal, fails otherwise
/// Optionally allows an additional message in the case of a failure
#define TEST_ASSERT_EQUAL(a, b, message) \
	do { \
		var/lhs = ##a; \
		var/rhs = ##b; \
		if (lhs != rhs) { \
			return Fail("Expected [isnull(lhs) ? "null" : lhs] to be equal to [isnull(rhs) ? "null" : rhs].[message ? " [message]" : ""]"); \
		} \
	} while (FALSE)

/// Asserts that the two parameters passed are not equal, fails otherwise
/// Optionally allows an additional message in the case of a failure
#define TEST_ASSERT_NOTEQUAL(a, b, message) \
	do { \
		var/lhs = ##a; \
		var/rhs = ##b; \
		if (lhs == rhs) { \
			return Fail("Expected [isnull(lhs) ? "null" : lhs] to not be equal to [isnull(rhs) ? "null" : rhs].[message ? " [message]" : ""]"); \
		} \
	} while (FALSE)

/// *Only* run the test provided within the parentheses
/// This is useful for debugging when you want to reduce noise, but should never be pushed
/// Intended to be used in the manner of `TEST_FOCUS(/datum/unit_test/math)`
#define TEST_FOCUS(test_path) ##test_path { focus = TRUE; }

/// Constants indicating unit test completion status
#define UNIT_TEST_PASSED 0
#define UNIT_TEST_FAILED 1
#define UNIT_TEST_SKIPPED 2

//Keep this sorted alphabetically
#include "anchored_mobs.dm"
#include "character_saving.dm"
#include "combat.dm"
#include "component_tests.dm"
#include "designs.dm"
#include "initialize_sanity.dm"
#include "medical_wounds.dm"
#include "merge_type.dm"
#include "metabolizing.dm"
#include "pills.dm"
#include "plantgrowth_tests.dm"
#include "reagent_id_typos.dm"
#include "reagent_mod_procs.dm"
#include "reagent_recipe_collisions.dm"
#include "resist.dm"
#include "spawn_mobs.dm"
#include "subsystem_init.dm"
#include "surgeries.dm"
#include "timer_sanity.dm"
#include "unit_test.dm"

#undef TEST_ASSERT
#undef TEST_ASSERT_EQUAL
#undef TEST_ASSERT_NOTEQUAL
#undef TEST_FOCUS
#endif
