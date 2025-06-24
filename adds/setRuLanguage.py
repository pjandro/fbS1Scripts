import base64

file = open("moonraker.db", "r")

result = []
while True:
    line = file.readline()
    if not line:
        break
    splitted = line.split(":")[1].split("->")
    key = base64.b64decode(splitted[0]).decode()
    value = base64.b64decode(splitted[1]).decode()
    if key.startswith("uiSettings"):
        newValue = base64.b64encode(value.replace('"locale": "zh-CN"', '"locale": "ru-RU"').encode()).decode()
        fullNewStr = f"+16,{len(newValue)}:{splitted[0]}->{newValue}\n"
        result.append(fullNewStr)
    else:
        result.append(line)
file.close()
file = open("moonraker_updated.db", "w")
file.write("".join(result))
file.close()
