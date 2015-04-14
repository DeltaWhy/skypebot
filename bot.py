#!/usr/bin/python2
import glib
import dbus
import time
import sys,os,fcntl
from ldtp import *
from ldtputils import *

def send(msg):
    activatewindow('*-Skype*')
    msgs = msg.replace("<","<<>").replace("\\","\\\\").split("\n")
    for m in msgs[0:-1]:
        generatekeyevent(m+"<Shift><Return>")
    generatekeyevent(msgs[-1]+'<Return>')
    generatemouseevent(0,0)

from dbus.mainloop.glib import DBusGMainLoop

def notifications(bus, message):
    if message.get_member() == "Notify":
        args = message.get_args_list()
        if str(args[2]) == '/usr/share/icons/hicolor/48x48/apps/skype.png':
            match = re.match(r'\<b\>(.*)\</b\>: (.*)', str(args[4]))
            if match:
                onMessage(*match.groups())

def onMessage(sender, message):
    print "%s: %s"%(sender, message)

DBusGMainLoop(set_as_default=True)

bus = dbus.SessionBus()
bus.add_match_string_non_blocking("interface='org.freedesktop.Notifications',eavesdrop='true'")
bus.add_message_filter(notifications)

class IODriver(object):
    def __init__(self, line_callback):
        self.buffer = ''
        self.line_callback = line_callback
        flags = fcntl.fcntl(sys.stdin.fileno(), fcntl.F_GETFL)
        flags |= os.O_NONBLOCK
        fcntl.fcntl(sys.stdin.fileno(), fcntl.F_SETFL, flags)
        glib.io_add_watch(sys.stdin, glib.IO_IN, self.io_callback)

    def io_callback(self, fd, condition):
        chunk = fd.read()
        for char in chunk:
            self.buffer += char
            if char == '\n':
                self.line_callback(self.buffer)
                self.buffer = ''

        return True

d = IODriver(send)

mainloop = glib.MainLoop()
mainloop.run()
