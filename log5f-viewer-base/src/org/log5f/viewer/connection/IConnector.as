package org.log5f.viewer.connection
{
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;

	public interface IConnector extends IEventDispatcher
	{
		function get status():String;
		
		function get entries():IList;
		
		/** @throws ArgumentError */
		function connect(dest:Object):void;
		
		function close():void;
	}
}