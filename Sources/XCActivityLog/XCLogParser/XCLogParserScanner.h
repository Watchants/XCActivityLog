//
// Created by panghu on 8/28/20.
//

#ifndef XCLOGPARSERSCANNER_H
#define XCLOGPARSERSCANNER_H

#include <cstdlib>

namespace Watchants {

    class XCLogParserScanner {
    public:
        const uint8_t * string;
        size_t advance;
        size_t size;
    public:
        XCLogParserScanner(const uint8_t * string, size_t size);
        ~XCLogParserScanner();
    public:
        bool scanString(const uint8_t * keys, size_t size);
        bool scanCharacters(const uint8_t * keys, size_t size, size_t * location, size_t * length);
    };

}

#endif //XCLOGPARSERSCANNER_H
