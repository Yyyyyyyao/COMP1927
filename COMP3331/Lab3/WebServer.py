from socket import *
import os
import sys

# take in the argument
serverPort = int(sys.argv[1])

# connect in TCP 
serverSocket = socket(AF_INET, SOCK_STREAM)

#bind the serverSocket with the Port 
serverSocket.bind(('', serverPort))

# listen in an infinte loop
serverSocket.listen(1)
print "The server is ready to receive"
while 1:

	# Server accept an Client
    connectionSocket, addr = serverSocket.accept()
    try:
        # receive the data from the socket
        sentence = connectionSocket.recv(1024)

        #Split the GET request; only take the http://XXXX
        temp = sentence.split(" ")
        target = temp[1]

        # Split the http://XXXXX and only take the value we need 
        # like index.html
        temp2 = target.split("/")
        #print(temp2)
        html = temp2[1]
        
        #open the requested file 
        file = open(html)

        # take in the data of the file
        data = file.read()

        # if there do have this file, i send this to the Clinet w with header 200ok
        connectionSocket.send("HTTP/1.1 200 OK\n\n")

        # send the data        
        connectionSocket.send(data)
        
        # close the socket
        connectionSocket.close()

    except IOError:
    	# if there is no such file existing 
    	# first send the header
        connectionSocket.send("HTTP/1.1 404 Not Found\n\n")
        # the send the body
        r = "<html><body>404 NOT FOUND</body></html>"
    	connectionSocket.send(r)
    	connectionSocket.close()
