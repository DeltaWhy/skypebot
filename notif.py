import glib
import dbus
from dbus.mainloop.glib import DBusGMainLoop

def notifications(bus, message):
    if message.get_member() == "Notify":
        print [arg for arg in message.get_args_list()]

DBusGMainLoop(set_as_default=True)

bus = dbus.SessionBus()
bus.add_match_string_non_blocking("interface='org.freedesktop.Notifications',eavesdrop='true'")
bus.add_message_filter(notifications)

mainloop = glib.MainLoop()
mainloop.run()
