#ifndef HyperscanHelper
#define HyperscanHelper

#include <stdio.h>

#include <hs_common.h>
#include <hs.h>

typedef struct swift_hs_database {
    hs_database_t *database;
} swift_hs_database_t;

typedef struct swift_hs_compile_error {
    hs_compile_error_t *error;
} swift_hs_compile_error_t;

typedef struct swift_hs_scracth {
    hs_scratch_t *scratch;
} swift_hs_scratch_t;

hs_error_t HS_CDECL swift_hs_compile(const char *expression, unsigned int flags,
                                     unsigned int mode, const hs_platform_info_t *platform,
                                     swift_hs_database_t *db, swift_hs_compile_error_t *error) {
    
    return hs_compile(expression, flags, mode, platform, &(db->database), &(error->error));
}

hs_error_t HS_CDECL swift_hs_alloc_scratch(const swift_hs_database_t *db, swift_hs_scratch_t *scratch) {
    
    return hs_alloc_scratch(db->database, &(scratch->scratch));
}

hs_error_t HS_CDECL swift_hs_scan(const swift_hs_database_t *db, const char *data,
                                  unsigned int length, swift_hs_scratch_t *scratch,
                                  match_event_handler onEvent, void *context) {
    
    return hs_scan(db->database, data, length, 0, scratch->scratch, onEvent, context);
}

HS_CDECL swift_print_compile_error(const swift_hs_compile_error_t *error) {
    
    fprintf(stderr, "%s\n", error->error->message);
}

#endif
