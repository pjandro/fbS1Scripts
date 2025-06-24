import base64
import sys

file = open("moonraker.db", "r")

result = []
printerIp = sys.argv[1]
pattern = '{"name": "timelapse", "service": "mjpegstreamer", "targetFps": 15, "urlStream": "http://{printerIp}:8080/?action=stream", "urlSnapshot": "http://{printerIp}:8080/?action=snapshot", "flipX": false, "flipY": false, "enabled": true, "targetFpsIdle": 5, "aspectRatio": "4:3", "icon": "mdiWebcam", "location": "printer", "rotation": 0, "extra_data": {}}'
webcams = False
webCamAdded = False
while True:
    line = file.readline()
    if not line:
        break
    splitted = line.split(":")[1].split("->")
    key = base64.b64decode(splitted[0]).decode()
    value = base64.b64decode(splitted[1]).decode()
    if key.startswith("namespace_webcams"):
        webcams = True
        newValue = base64.b64encode(b"entries=1").decode()
        fullNewStr = f"+24,{len(newValue)}:{splitted[0]}->{newValue}\n"
        result.append(fullNewStr)
        continue
    if webcams:
        if webCamAdded:
            continue
        newValue = pattern.replace("{printerIp}", printerIp)
        newValue = base64.b64encode(newValue.encode()).decode()
        fullNewStr = f"+48,{len(newValue)}:{splitted[0]}->{newValue}\n"
        result.append(fullNewStr)
        webCamAdded = True
    else:
        result.append(line)
file.close()
file = open("moonraker_updated.db", "w")
file.write("".join(result))
file.close()
