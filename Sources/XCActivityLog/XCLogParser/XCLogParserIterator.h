//
// Created by panghu on 8/28/20.
//

#ifndef XCLOGPARSERITERATOR_H
#define XCLOGPARSERITERATOR_H

#include <cstdlib>

#include "XCActivityLogItem.h"
#include "XCLogParserScanner.h"

namespace Watchants {

    struct XCLogParserIteratorPayload {
        size_t location;
        size_t length;
    };

    struct XCLogParserIteratorDelimiters {
        size_t location;
        size_t length;
        size_t advance;
    };

    class XCLogParserIterator {
    private:
        XCLogParserScanner *scanner;
        XCLogParserIteratorPayload *payload;
        XCLogParserIteratorDelimiters *delimiters;
    public:
        XCLogParserIterator(XCLogParserScanner *scanner);
        ~XCLogParserIterator();
    private:
        bool scanPayload();
        bool scanDelimiters();
    public:
        bool scanSLF0Head();
        XCActivityLogItemRef next();
    };

}

#endif //XCLOGPARSERITERATOR_H
