package org.log5f.viewer.connection.impl
{
	import flash.events.AsyncErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	
	import mx.collections.IList;
	
	import org.log5f.viewer.connection.IConnector;
	import org.log5f.viewer.connection.events.ConnectorEvent;
	
	public class NetGroupConnector extends EventDispatcher implements IConnector
	{
		public function NetGroupConnector(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private var conn:NetConnection;
		private var group:NetGroup;
		
		private var connDest:String;
		private var groupName:String;
		
		private var data:Array;
		
		public function get status():String
		{
			return null;
		}
		
		public function get entries():IList
		{
			return null;
		}
		
		public function connect(dest:Object):void
		{
			this.retrieveDestinationParts(dest);
			
			this.connectInternal();
		}
		
		public function close():void
		{
			if (this.group)
			{
				this.group.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				this.group.close();
				this.group = null;
			}
			
			if (this.conn)
			{
				this.conn.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				this.conn.removeEventListener(IOErrorEvent.IO_ERROR, conn_ioErrorHandler);
				this.conn.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, conn_asyncErrorHandler);
				this.conn.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, conn_securityErrorHandler);
				this.conn.close();
				this.conn = null;
			}
		}
		
		private function connectInternal():void
		{
			if (!this.conn)
			{
				this.conn = new NetConnection();
				this.conn.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				this.conn.addEventListener(IOErrorEvent.IO_ERROR, conn_ioErrorHandler);
				this.conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, conn_asyncErrorHandler);
				this.conn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, conn_securityErrorHandler);
				
				this.conn.connect(this.connDest);
			}
			else if (!this.group && this.conn.connected)
			{
				const spec:GroupSpecifier = new GroupSpecifier(this.groupName);
				spec.postingEnabled = true;
				
				this.group = new NetGroup(this.conn, spec.groupspecWithoutAuthorizations());
				this.group.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			}
		}
		
		private function abend():void
		{
			this.dispatchEvent(new ConnectorEvent(ConnectorEvent.FAILURE));
			this.close();
		}
		
		/** @private */
		private function retrieveDestinationParts(dest:String):void
		{
			if (dest) 
			{
				const slash:int = dest.lastIndexOf("/");
				
				this.connDest = dest.substring(0, slash);
				this.groupName = dest.substring(slash + 1);
			}
			else
			{
				this.connDest = null;
				this.groupName = null;
			}
		}
		
		private function handleMessage(message:Object):void
		{
			if (message) return;
			
			this.data = message is Array ? message as Array : [message];
			
			this.dispatchEvent(new ConnectorEvent(ConnectorEvent.PORTION, this.data));
		}
		
		/** @private */
		private function netStatusHandler(event:NetStatusEvent):void
		{
			switch (event.info.code)
			{
				// NetConnection
				
				case "NetConnection.Connect.Success" :
					
					this.connectInternal();
					
					break;
				
				case "NetConnection.Connect.Failed" :
				case "NetConnection.Connect.Rejected" :
					
					this.abend();
					
					break;
				
				// NetGroup
				
				case "NetGroup.Posting.Notify" :
					
					this.handleMessage(event.info.message);
					
					break;

				case "NetGroup.Connect.Failed" :
				case "NetGroup.Connect.Rejected" :
					
					this.abend();
					
					break;
			}
		}
		
		private function conn_ioErrorHandler(event:IOErrorEvent):void
		{
			this.abend();
		}
		
		private function conn_asyncErrorHandler(event:AsyncErrorEvent):void
		{
			this.abend();
		}
		
		private function conn_securityErrorHandler(event:SecurityErrorEvent):void
		{
			this.abend();
		}
		
		
	}
}