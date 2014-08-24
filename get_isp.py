#!/usr/bin/env python

import html2text
import re
import sys
import urllib2

def get_isp(host):
    trac = "http://www.ip-adress.com/ip_tracer/"
    pat  = "ISP of this IP \[\?\]:\n\n([a-zA-Z ]+)"
    hdr  = {'User-Agent': 'Mozilla/5.0'} # ip-adress.com only accepts popular agents
    page = urllib2.urlopen(urllib2.Request(trac + host, headers=hdr)).read()

    h = html2text.HTML2Text()
    h.ignore_links = True
    text = h.handle(page)

    try:
        print "ISP for %s:\n" % host, re.search(pat, text).group(1)
    except:
        print "Could not find ISP for", host

def main():
    if len(sys.argv) != 2:
        print 'Usage: ' + sys.argv[0] + ' host.'
        sys.exit(1)

    get_isp(sys.argv[1])

if __name__ == "__main__":
    main()
