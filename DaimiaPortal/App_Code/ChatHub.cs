using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

public class ChatHub : Hub
{
    public void Send(String username, string message)
    {
        Clients.All.sendMessage(username);
    }
}
