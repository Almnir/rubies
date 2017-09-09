#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

#include <libxml/tree.h>
#include <libxml/parser.h>
#include <libxml/xpath.h>
#include <libxml/xpathInternals.h>

#if defined(LIBXML_XPATH_ENABLED) && defined(LIBXML_SAX1_ENABLED) && \
    defined(LIBXML_OUTPUT_ENABLED)

static void usage(const char *name);
static int parserParser(const char *filename1, const xmlChar * xpathExpr1,
                    const char *filename2, const xmlChar * xpathExpr2);
static void update_xpath_nodes(xmlNodeSetPtr nodes, const xmlChar * value);

int 
main(int argc, char **argv) {
    if (argc != 5) {
    fprintf(stderr, "Error: wrong number of arguments.\n");
    usage(argv[0]);
    return(-1);
    } 
    
    xmlInitParser();
    LIBXML_TEST_VERSION

    if (parserParser(argv[1], argv[2], argv[3])) {
    usage(argv[0]);
    return(-1);
    }

    xmlCleanupParser();
    
    // xmlMemoryDump();
    return 0;
}

static void 
usage(const char *name) {
    assert(name);
    
    fprintf(stderr, "Usage: %s <xml-file> <xpath-expr> <value>\n", name);
}

static int 
parserParser(const char *filename1, const xmlChar * xpathExpr1,
                    const char *filename2, const xmlChar * xpathExpr2) {
    xmlDocPtr doc;
    xmlXPathContextPtr xpathCtx; 
    xmlXPathObjectPtr xpathObj; 
    
    // assert(filename);
    // assert(xpathExpr);
    // assert(value);

    /* Load XML document */
    doc = xmlParseFile(filename1);
    if (doc == NULL) {
    fprintf(stderr, "Error: unable to parse file \"%s\"\n", filename);
    return(-1);
    }

    /* Create xpath evaluation context */
    xpathCtx = xmlXPathNewContext(doc);
    if(xpathCtx == NULL) {
        fprintf(stderr,"Error: unable to create new XPath context\n");
        xmlFreeDoc(doc); 
        return(-1);
    }
    
    /* Evaluate xpath expression */
    xpathObj = xmlXPathEvalExpression(xpathExpr, xpathCtx);
    if(xpathObj == NULL) {
        fprintf(stderr,"Error: unable to evaluate xpath expression \"%s\"\n", xpathExpr);
        xmlXPathFreeContext(xpathCtx); 
        xmlFreeDoc(doc); 
        return(-1);
    }

    /* update selected nodes */
    update_xpath_nodes(xpathObj->nodesetval, value);

    
    /* Cleanup of XPath data */
    xmlXPathFreeObject(xpathObj);
    xmlXPathFreeContext(xpathCtx); 

    /* free the document */
    xmlFreeDoc(doc); 
    
    return(0);
}

static void
update_xpath_nodes(xmlNodeSetPtr nodes, const xmlChar* value) {
    int size;
    int i;
    
    assert(value);
    size = (nodes) ? nodes->nodeNr : 0;
    
    for(i = size - 1; i >= 0; i--) {
    assert(nodes->nodeTab[i]);
    
    xmlNodeSetContent(nodes->nodeTab[i], value);
    if (nodes->nodeTab[i]->type != XML_NAMESPACE_DECL)
        nodes->nodeTab[i] = NULL;
    }
}