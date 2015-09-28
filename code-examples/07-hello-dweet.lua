-- 07-hello-dweet.lua
-- Send some test data to dweet.io
-- You should change this to something unique
-- Once you send some data, point your browser to:
-- http://dweet.io/follow/DWEET_ID
DWEET_ID = "fsm42"


tmr.alarm(0,10000,1,function()
    print ("loop start")

    -- Create the TCP connection
    conn = net.createConnection(net.TCP, 0)
    
    -- Add the "receive" handler
    conn:on("receive", function(conn, payload)
        print("response: ", payload)
    end) 
    
    -- Add the "connection" handler
    conn:on("connection", function(conn, payload)
        print("In callback connection")
        conn:send(
            "POST /dweet/for/" .. DWEET_ID .. 
            "?temperature=" .. math.random(-20, 50) .. 
            "&humidity=" .. math.random(-20, 50) ..
            " HTTP/1.1\r\nHost: dweet.io\r\n" ..
            "Connection: close\r\nAccept: */*\r\n\r\n"
        )
    end)

    -- Establish the connection
    conn:connect(80, "dweet.io")
    print("after connect")
end)