Xvfb -screen 0 1366x768x16 -ac > xvfb.log 2>&1 &
sleep 2
export DISPLAY=:0
export QT_ACCESSIBILITY=1
openbox &
lxsession &
x11vnc -shared -forever -display :0 > x11vnc.log 2>&1 &
skype
