//
//  XCActivityLog.h
//  XCActivityLog
//
//  Created by panghu on 9/19/20.
//

#ifndef XCACTIVITYLOG_H
#define XCACTIVITYLOG_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>
#include <stdbool.h>

#include "XCActivityLogItem.h"

typedef struct XCActivityLog {
    const void * parser;
    const void * iterator;
} XCActivityLog;

typedef const XCActivityLog * XCActivityLogRef;

extern XCActivityLogRef XCActivityLogCreate(const char * filepath);

extern void XCActivityLogRelease(XCActivityLogRef thisRef);

extern bool XCActivityLogSLF0Head(XCActivityLogRef thisRef);

extern XCActivityLogItemRef XCActivityLogNextItem(XCActivityLogRef thisRef);

extern void XCActivityLogReleaseItem(XCActivityLogItemRef thisRef);

#ifdef __cplusplus
}
#endif

#endif /* XCACTIVITYLOG_H */
