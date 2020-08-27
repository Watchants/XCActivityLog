//
// Created by panghu on 8/28/20.
//

#include "XCActivityLog.h"

#include "XCLogParser/XCLogParser.h"

XCActivityLogRef XCActivityLogCreate(const char * filepath) {
    XCActivityLog * ref = (XCActivityLog *)malloc(sizeof(XCActivityLog));
    Watchants::XCLogParser *parser = new Watchants::XCLogParser(filepath);
    ref->parser = parser;
    ref->iterator = parser->iterator();
    return ref;
}

void XCActivityLogRelease(XCActivityLogRef thisRef) {
    XCActivityLog * ref = (XCActivityLog *)thisRef;
    if (ref != NULL) {
        if (ref->iterator) {
            delete (Watchants::XCLogParserIterator *)ref->iterator;
            ref->iterator = NULL;
        }
        if (ref->parser) {
            delete (Watchants::XCLogParser *)ref->parser;
            ref->parser = NULL;
        }
        free(ref);
    }
}

bool XCActivityLogSLF0Head(XCActivityLogRef thisRef) {
    Watchants::XCLogParserIterator *iterator = (Watchants::XCLogParserIterator *)thisRef->iterator;
    if (iterator != NULL) {
        return iterator->scanSLF0Head();
    } else {
        return false;
    }
}

XCActivityLogItemRef XCActivityLogNextItem(XCActivityLogRef thisRef) {
    Watchants::XCLogParserIterator *iterator = (Watchants::XCLogParserIterator *)thisRef->iterator;
    return iterator->next();
}

void XCActivityLogReleaseItem(XCActivityLogItemRef thisRef) {
    XCActivityLogItemRelease(thisRef);
}
