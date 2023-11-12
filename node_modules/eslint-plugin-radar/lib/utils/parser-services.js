"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isRequiredParserServices = void 0;
function isRequiredParserServices(services) {
    return !!services && !!services.program && !!services.esTreeNodeToTSNodeMap;
}
exports.isRequiredParserServices = isRequiredParserServices;
//# sourceMappingURL=parser-services.js.map