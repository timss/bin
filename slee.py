#!/usr/bin/env python

from __future__ import print_function
import sys, re, os


def sleepy(client, nick, network, channel):
    """ Find out how much someone talks about sleep(ing) """
    client = client.lower()

    if client == 'irssi':
        log_file = "%s/irclogs/%s/%.log" % \
                   (os.getenv('HOME'), network, channel)
    elif client == "weechat":
        log_file = "%s/.weechat/logs/irc.%s.%s.weechatlog" % \
                   (os.getenv('HOME'), network, channel)
    else:
        print("Unknown client. \n" +
              "Supported: Irssi, WeeChat.")
        sys.exit(1)

    try:
        log   = open(log_file, 'r')
        count = 0
        expr  = "^.*" + nick + "(\@|\+)?[\:]?.*\s+" + \
                "(legge(r)?[\s]meg|night|nn|n|gn)(\s|\.|\,|$).*$"

        for line in log:
            if re.match(expr, line, re.IGNORECASE):
                print(line, end='')
                count += 1
        print("\nTimes talked about sleeping: " + str(count))

        log.close()
    except IOError:
        print("Error opening " + log_file)
        sys.exit(1)


def main():
    if len(sys.argv) < 5:
        print("Usage: slee.py client nick network \"#channel\"\n" +
              "Example: weechat anon Freenode \"#linux\"")
    else:
        sleepy(*sys.argv[1:5])

if __name__ == '__main__':
    main()
