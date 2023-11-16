import asyncio
import websockets
import json
import random
import time

# 房间编号 - 10000 ~ 99999
rooms_num = 9999
# Key: ID - Value: Websockets
ID_Websocket = {}
# Key: 房间号 - Value: 房间信息
Rooms = {}
# Key: ID - Value: 房间号
ID_Room = {}
# Key: 房间号 - Value: 游戏信息
Games = {}

# 创建房间
def create_room (ID):
    global rooms_num
    rooms_num = rooms_num + 1
    if (rooms_num == 100000):
        rooms_num = 10000
    Rooms[str(rooms_num)] = {
        "players": [ID, None],
        "ready": [False, False],
        "state": "waiting"
    }
    ID_Room[ID] = str(rooms_num)
    return str(rooms_num)

# 判断是否都准备
def is_ready_to_play (roomnum):
    for ready in Rooms[roomnum]["ready"]:
        if (ready == False):
            return False
    return True

# 房间内玩家准备
def update_ready_room (ID):
    for i in range(2):
        if (Rooms[ID_Room[ID]]["players"][i] == ID):
            Rooms[ID_Room[ID]]["ready"][i] = not Rooms[ID_Room[ID]]["ready"][i]
    return ID_Room[ID]

# 玩家加入房间
def player_join_room (ID, roomnum):
    for i in range(2):
        if (Rooms[roomnum]["players"][i] == None):
            Rooms[roomnum]["players"][i] = ID
            Rooms[roomnum]["ready"][i] = False
            ID_Room[ID] = roomnum
            return True
    return False

# 玩家退出房间
def player_quit_room (ID):
    if (ID not in ID_Room):
        return (0, 0)
    num = ID_Room[ID]
    ID_Room.pop(ID)
    if (num not in Rooms):
        return (0, 0)
    if (Rooms[num]["state"] == "waiting"):
        checkNone = False
        for i in range(2):
            if (Rooms[num]["players"][i] == ID):
                Rooms[num]["players"][i] = None
                Rooms[num]["ready"][i] = False
            elif (Rooms[num]["players"][i] == None):
                checkNone = True
        if (checkNone == True):
            Rooms.pop(num)
            return (0, 0)
        return (0, num)
    else:
        for i in range(2):
            Rooms[num]["ready"][i] = False
            if (Rooms[num]["players"][i] == ID):
                Rooms[num]["players"][i] = None
        Rooms[num]["state"] = "waiting"
        return (1, num)
    
# 玩家随机加入
def player_rand_join ():
    for roomnum in Rooms:
        if (Rooms[roomnum]["players"][0] == None or Rooms[roomnum]["players"][1] == None):
            return roomnum
    return 0

# 开始对局
def start_game (roomnum):
    Rooms[roomnum]["state"] = "playing"
    Games[roomnum] = {
        "players": Rooms[roomnum]["players"],
        "seeds": [random.randint(0, 2 ** 32), random.randint(0, 2 ** 32)],
        "roundready": [False, False],
        "operations": [[], []]
    }

# 对局 - 玩家升级操作
def player_operation_buy (ID, num, timestamp):
    roomnum = ID_Room[ID]
    for i in range(2):
        if (Games[roomnum]["players"][i] == ID):
            Games[roomnum]["operations"][i].append((num, timestamp))

# 对局 - 玩家升级操作
def player_operation_levelup (ID, timestamp):
    roomnum = ID_Room[ID]
    for i in range(2):
        if (Games[roomnum]["players"][i] == ID):
            Games[roomnum]["operations"][i].append(("levelup", timestamp))

# 对局 - 玩家刷新操作
def player_operation_refresh (ID, timestamp):
    roomnum = ID_Room[ID]
    for i in range(2):
        if (Games[roomnum]["players"][i] == ID):
            Games[roomnum]["operations"][i].append(("refresh", timestamp))

# 对局 - 玩家回合结束操作
def player_operation_turnend (ID, timestamp):
    roomnum = ID_Room[ID]
    for i in range(2):
        if (Games[roomnum]["players"][i] == ID):
            Games[roomnum]["operations"][i].append(("turnend", timestamp))
            Games[roomnum]["roundready"][i] = True

# 对局 - 判断是否都结束回合
def is_ready_to_roundend (roomnum):
    for ready in Games[roomnum]["roundready"]:
        if (ready == False):
            return False
    return True

async def server (websocket, path):
    try:
        async for message in websocket:
            message = json.loads(message)

            if (message["type"] == "connect"):
                ID = message["ID"]
                if (ID in ID_Websocket):
                    await websocket.send(json.dumps({"type": "connect", "data": "NO"}))
                else:
                    print("Client get id: %s" % ID)
                    ID_Websocket[ID] = websocket
                    await ID_Websocket[ID].send(json.dumps({"type": "connect", "data": "OK", "ID": ID}))

            if (message["type"] == "createroom"):
                ID = message["ID"]
                getnum = create_room(ID)
                await websocket.send(json.dumps({"type": "createroom", "data": getnum}))
                await websocket.send(json.dumps({"type": "roomdetail", "data": Rooms[getnum]}))
            
            if (message["type"] == "ready"):
                ID = message["ID"]
                getnum = update_ready_room(ID)
                for playerID in Rooms[getnum]["players"]:
                    if (playerID != None):
                        await ID_Websocket[playerID].send(json.dumps({"type": "roomdetail", "data": Rooms[getnum]}))
                # 全员准备后开始游戏
                if (is_ready_to_play(getnum) == True):
                    start_game(getnum)
                    for i in range(2):
                        if (Rooms[getnum]["players"][i] != None):
                            await ID_Websocket[Rooms[getnum]["players"][i]].send(json.dumps({"type": "startgame", "playid": i, "seed0": Games[getnum]["seeds"][0], "seed1": Games[getnum]["seeds"][1]}))

            if (message["type"] == "joinroom"):
                ID = message["ID"]
                num = message["roomnum"]
                if (num in Rooms):
                    sta = player_join_room(ID, num)
                    if (sta == True):
                        await websocket.send(json.dumps({"type": "joinroom", "data": num}))
                        for playerID in Rooms[num]["players"]:
                            if (playerID != None):
                                await ID_Websocket[playerID].send(json.dumps({"type": "roomdetail", "data": Rooms[num]}))
                    else:
                        await websocket.send(json.dumps({"type": "joinroom", "data": "FULL"}))
                else:
                    await websocket.send(json.dumps({"type": "joinroom", "data": "NOTFIND"}))
            
            if (message["type"] == "randjoin"):
                ID = message["ID"]
                num = player_rand_join()
                if (num != 0):
                    sta = player_join_room(ID, num)
                    if (sta == True):
                        await websocket.send(json.dumps({"type": "joinroom", "data": num}))
                        for playerID in Rooms[num]["players"]:
                            if (playerID != None):
                                await ID_Websocket[playerID].send(json.dumps({"type": "roomdetail", "data": Rooms[num]}))
                    else:
                        await websocket.send(json.dumps({"type": "joinroom", "data": "FULL"}))

            if (message["type"] == "quitroom"):
                ID = message["ID"]
                type, num = player_quit_room(ID)
                if (num != 0):
                    for playerID in Rooms[num]["players"]:
                        if (playerID != None):
                            await ID_Websocket[playerID].send(json.dumps({"type": "roomdetail", "data": Rooms[num]}))
            
            if (message["type"] == "chat"):
                ID = message["ID"]
                data = message["data"]
                num = ID_Room[ID]
                for playerID in Rooms[num]["players"]:
                    if (playerID != None):
                        await ID_Websocket[playerID].send(json.dumps({"type": "chat", "data": data, "ID": ID}))
            
            if (message["type"] == "gameoperation"):
                ID = message["ID"]
                print(message["op"])
                if (message["op"] == "buy"):
                    player_operation_buy(ID, message["number"])
                if (message["op"] == "levelup"):
                    player_operation_levelup(ID)
                if (message["op"] == "refresh"):
                    player_operation_refresh(ID)
                if (message["op"] == "turnend"):
                    player_operation_turnend(ID)
                    if (is_ready_to_roundend(ID_Room[ID])):
                        roomnum = ID_Room[ID]
                        optList = Games[roomnum]["operations"]
                        Games[roomnum]["roundready"] = [False, False]
                        Games[roomnum]["operations"] = [[], []]
                        for i in range(2):
                            for opt in optList[1 - i]:
                                if (opt[0] == "levelup"):
                                    await ID_Websocket[Games[roomnum]["players"][i]].send(json.dumps({"type": "gameoperation", "op": "levelup", "timestamp": opt[1]}))
                                elif (opt[0] == "refresh"):
                                    await ID_Websocket[Games[roomnum]["players"][i]].send(json.dumps({"type": "gameoperation", "op": "refresh", "timestamp": opt[1]}))
                                elif (opt[0] == "turnend"):
                                    await ID_Websocket[Games[roomnum]["players"][i]].send(json.dumps({"type": "gameoperation", "op": "turnend", "timestamp": opt[1]}))
                                else:
                                    await ID_Websocket[Games[roomnum]["players"][i]].send(json.dumps({"type": "gameoperation", "op": "buy", "number": opt[0], "timestamp": opt[1]}))
            
            if (message["type"] == "endgame"):
                pass



    except websockets.exceptions.ConnectionClosedError as error:
        deleteUserList = []
        for ID in ID_Websocket:
            try:
                await ID_Websocket[ID].send(json.dumps({"type": "check"}))
            except websockets.exceptions.ConnectionClosedError as error:
                deleteUserList.append(ID)
        for ID in deleteUserList:
            type, num = player_quit_room(ID)
            if (type == 0 and num != 0 and num in Rooms):
                for playerID in Rooms[num]["players"]:
                    if (playerID != None):
                        await ID_Websocket[playerID].send(json.dumps({"type": "roomdetail", "data": Rooms[num]}))
            elif (type == 1 and num in Rooms):
                for playerID in Rooms[num]["players"]:
                    if (playerID != None):
                        await ID_Websocket[playerID].send(json.dumps({"type": "endgame", "roomnum": num, "reason": "quit"}))
                        await ID_Websocket[playerID].send(json.dumps({"type": "roomdetail", "data": Rooms[num]}))
            ID_Websocket.pop(ID)

print("Server started")

loop = asyncio.new_event_loop()
asyncio.set_event_loop(loop)


loop.run_until_complete(websockets.serve(server, "", 8000))
loop.run_forever()