package org.log5f.viewer.connection.events
{
	import flash.events.Event;
	
	public class ConnectorEvent extends Event
	{
		public static const SUCCESS:String = "success";

		public static const FAILURE:String = "failure";
		
		public static const PORTION:String = "portion";
		
		public function ConnectorEvent(type:String, data:Array=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this._data = data;
		}
		
		private var _data:Array;
		
		public function get data():Array
		{
			return this._data;
		}
	}
}