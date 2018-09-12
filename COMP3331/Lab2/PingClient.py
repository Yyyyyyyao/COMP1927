import sys
import time
total = len(sys.argv)

from socket import *

serverName = str(sys.argv[1])
serverPort = int(sys.argv[2])
clientSocket = socket(AF_INET, SOCK_DGRAM)
clientSocket.settimeout(1)

clientSocket.connect((serverName, serverPort))

array = []

num = 0
num_success = 0
while num < 10:

	start = time.time()
	message = "PING" + str(num) + str(start) + "\r\n"
	#clientSocket.connect((serverName, serverPort))   #because it is persistent
	clientSocket.send(message.encode('utf-8'))
	

	try:
		modifiedSentence = clientSocket.recv(1024)
		end = time.time()
		result = round((end - start)*1000)
		print("ping to 127.0.0.1, seq =", num, ", rtt =", result, "ms")
		array.append(result)
		num_success += 1

	except timeout:
		print("ping to 127.0.0.1, seq =", num, ", time out" )

	num = num +1


maxValue = max(array)
minValue = min(array)
avgValue = round(sum(array)/num_success)

print("MAX RTT:", maxValue, "MIN RTT:", minValue, "AVG RTT:", avgValue)


clientSocket.close()
