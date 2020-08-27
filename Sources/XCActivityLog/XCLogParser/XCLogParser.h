//
// Created by panghu on 8/28/20.
//

#ifndef XCLOGPARSER_H
#define XCLOGPARSER_H

#include <cstdlib>

#include "XCLogParserScanner.h"
#include "XCLogParserIterator.h"

namespace Watchants {

    class XCLogParser {
    private:
        int fd;
        size_t size;
        uint8_t *mem;
        XCLogParserScanner *scanner;
    public:
        XCLogParser(const char * filepath);
        ~XCLogParser();
    public:
        XCLogParserIterator * iterator();
    };
}

#endif //XCLOGPARSER_H
