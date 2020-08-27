//
// Created by panghu on 8/28/20.
//

#include "XCLogParserIterator.h"

#include <cstring>

#include "XCActivityLogItem.h"

namespace Watchants {

    XCLogParserIterator::XCLogParserIterator(XCLogParserScanner *scanner) {
        this->scanner = scanner;
        this->payload = new XCLogParserIteratorPayload();
        this->delimiters = new XCLogParserIteratorDelimiters();
    }

    XCLogParserIterator::~XCLogParserIterator() {
        delete this->payload;
        delete this->delimiters;
    }

    XCActivityLogItemRef XCLogParserIterator::next() {
        if (this->delimiters->advance >= this->delimiters->length) {
            this->scanPayload();
            if (!this->scanDelimiters()) {
                return XCActivityLogItemCreate(this->scanner, "", '\0');
            }
        }
        char payload[this->payload->length + 1];
        memcpy(payload, this->scanner->string + this->payload->location, this->payload->length);
        payload[this->payload->length] = '\0';
        char delimiter = this->scanner->string[this->delimiters->location + this->delimiters->advance];
        this->delimiters->advance += 1;
        return XCActivityLogItemCreate(this->scanner, payload, delimiter);
    }

    bool XCLogParserIterator::scanSLF0Head() {
        return this->scanner->scanString(XCActivityLogSLF0Type, XCActivityLogSLF0TypeSize);
    }

    bool XCLogParserIterator::scanPayload() {
        size_t location;
        size_t length;
        bool result = this->scanner->scanCharacters(XCActivityLogNumerics, XCActivityLogNumericsSize, &location, &length);
        this->payload->location = location;
        this->payload->length = length;
        return result;
    }

    bool XCLogParserIterator::scanDelimiters() {
        size_t location;
        size_t length;
        bool result = this->scanner->scanCharacters(XCActivityLogDelimiters, XCActivityLogDelimitersSize, &location, &length);
        if (!result) {
            this->delimiters->location = 0;
            this->delimiters->length = 0;
            this->delimiters->advance = 0;
        } else {
            if (length > 0 && this->scanner->string[location] == '"') {
                this->scanner->advance -= (length - 1);
                this->delimiters->location = location;
                this->delimiters->length = 1;
                this->delimiters->advance = 0;
            } else {
                this->delimiters->location = location;
                this->delimiters->length = length;
                this->delimiters->advance = 0;
            }
        }
        return result;
    }
}
