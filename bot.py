import glib
import dbus
from ldtp import *
from ldtputils import *
launchapp('skype')
waittillguiexist('Skype*forLinux')
